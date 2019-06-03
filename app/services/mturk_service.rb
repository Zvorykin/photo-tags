# frozen_string_literal: true

module MturkService
  TEST_ENDPOINT = 'https://mturk-requester-sandbox.us-east-1.amazonaws.com'
  TEST_REGION = 'us-east-1'

  class << self
    def balance
      client.get_account_balance[:available_balance]
    end

    def list_hits(params)
      amount = params[:amount]
      next_token = params[:next_token]

      client.list_hits(
        max_results: amount || 100,
        next_token: next_token
      )
    end

    def create_hit(params)
      title = params[:title]
      description = params[:description]
      reward = params[:reward].to_s
      assignment_duration = params[:assignment_duration]
      lifetime = params[:lifetime]
      question = QuestionService.new.question

      client.create_hit(
        title: title,
        description: description,
        reward: reward,
        assignment_duration_in_seconds: assignment_duration,
        lifetime_in_seconds: lifetime,
        question: question
      )
    end

    def hit_assignments(id)
      client.list_assignments_for_hit(
        hit_id: id
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