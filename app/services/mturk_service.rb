# frozen_string_literal: true

module MturkService
  TEST_ENDPOINT = 'https://mturk-requester-sandbox.us-east-1.amazonaws.com'
  TEST_REGION = 'us-east-1'

  class << self
    def balance
      client.get_account_balance[:available_balance]
    end

    def list_hits(amount = 50, next_token = nil)
      client.list_hits(
        max_results: amount,
        next_token: next_token
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