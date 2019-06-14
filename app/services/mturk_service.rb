# frozen_string_literal: true

module MturkService
  TEST_ENDPOINT = 'https://mturk-requester-sandbox.us-east-1.amazonaws.com'
  TEST_REGION = 'us-east-1'

  SUBMITTED_STATUS = 'Submitted'
  RESULT_REGEX = /<FreeText>(\[{.*}\])<\/FreeText>/.freeze

  class << self
    def balance
      client.get_account_balance[:available_balance]
    end

    def list_hits(params)
      client.list_hits(
        max_results: params[:max_results] || 100,
        next_token: params[:next_token]
      )
    end

    def create_hit(params)
      question = QuestionService.new.question

      client.create_hit(
        title: params[:title],
        description: params[:description],
        reward: params[:reward].to_s,
        assignment_duration_in_seconds: params[:assignment_duration],
        lifetime_in_seconds: params[:lifetime],
        max_assignments: params[:max_assignments],
        question: question
      ).hit
    end

    def update_hit_submitted_assignments(params)
      hit_id = params[:hit_id]
      assignments = hit_submitted_assignments(hit_id: hit_id).assignments

      assignments.each do |item|
        answer = item[:answer].match(RESULT_REGEX)&.captures&.first

        unless answer.present?
          Rails.logger.warn("Result not found! #{item}")
          next
        end

        assignment = Assignment.find_or_initialize_by(
          assignment_id: item[:assignment_id]
        )

        next if assignment.persisted?

        assignment.assign_attributes(
          hit_id: hit_id,
          status: item[:assignment_status],
          submit_time: item[:submit_time],
          answers: JSON.parse(answer, symbolize_names: true),
          payload: item.to_h
        )
        assignment.save
      end
    end

    def hit_submitted_assignments(params)
      client.list_assignments_for_hit(
        hit_id: params[:hit_id],
        max_results: params[:max_results] || 100,
        next_token: params[:next_token],
        assignment_statuses: [SUBMITTED_STATUS]
      )
    end

    private

    def client
      @client ||= create_client
    end

    def create_client
      params = {
        credentials: credentials,
        region: region
      }
      params[:endpoint] = TEST_ENDPOINT unless Rails.env.production?

      Aws::MTurk::Client.new(params)
    end

    def credentials
      Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY']
      )
    end

    def region
      Rails.env.production? ? ENV['AWS_REGION'] : TEST_REGION
    end
  end
end