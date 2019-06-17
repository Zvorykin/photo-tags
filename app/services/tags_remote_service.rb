# frozen_string_literal: true

module TagsRemoteService
  class << self
    API_PHOTOS_ENDPOINT = 'https://demo-photos.icons8.com/api/v1/tags'
    MAX_AMOUNT_PER_PAGE = 50
    FIELDS = %w[id title].freeze

    class << self
      def get_all_tags
        tags = []
        page = 1
        params[:per_page] = MAX_AMOUNT_PER_PAGE

        # waiting for related remote route creation

        # loop
        #   params[:page] = page
        #   res_photos = search(params)[:photos]
        #
        #   break if res_photos.size.zero?
        #
        #   photos.concat(res_photos)
        #   page += 1
        # end
        #
        #
        # {
        #   photos: photos.map(&:symbolize_keys),
        #   amount: photos.size
        # }
      end

      private

      def client
        @client ||= create_client
      end

      def create_client
        Faraday.new(API_PHOTOS_ENDPOINT) do |faraday|
          faraday.response(:json)
          faraday.request(:json)
          faraday.use Faraday::Response::RaiseError
          faraday.adapter Faraday.default_adapter
        end
      end

      def add_fields_param(params)
        params.merge(fields: FIELDS.join(','))
      end
    end
  end
end