# frozen_string_literal: true

module PhotosRemoteService
  API_PHOTOS_ENDPOINT = 'https://demo-photos.icons8.com/api/frontend/v1/photos'

  FIELDS = %w[id tags thumb1xUrl preview1xUrl].freeze

  class << self
    def search(params)
      params_with_fields_filter = add_fields_param(params)
      data = client.get('', params_with_fields_filter).body

      {
        photos: data['photos'],
        total: data['total']
      }
    end

    # TODO: rewrite using typhoeus parallel request if needed
    def by_ids(ids)
      Array.wrap(ids).each_with_object([]) { |id, result| result << find_by_id(id) }
    end

    private

    def client
      @client ||= create_client
    end

    def create_client
      Faraday.new(API_PHOTOS_ENDPOINT) do |faraday|
        faraday.response(:json)
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def find_by_id(id)
      client.get(id).body.slice(*FIELDS)
    end

    def add_fields_param(params)
      params.merge(fields: FIELDS.join(','))
    end
  end
end