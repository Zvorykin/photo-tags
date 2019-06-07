# frozen_string_literal: true

module PhotosRemoteService
  API_PHOTOS_ENDPOINT = 'https://photos.icons8.com/api/v1/photos'

  class << self
    def search(params)
      client.get('search', params).body['photos']
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
  end
end