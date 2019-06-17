# frozen_string_literal: true

module PhotosRemoteService
  API_PHOTOS_ENDPOINT = 'https://demo-photos.icons8.com/api/v1/photos'
  MAX_AMOUNT_PER_PAGE = 100
  FIELDS = %w[id tags thumb1xUrl preview1xUrl filename title].freeze

  class << self
    def search(params)
      params_with_fields_filter = add_fields_param(params)
      client.get('search', params_with_fields_filter).body.symbolize_keys
    end

    # TODO: rewrite using typhoeus parallel request if needed
    def by_ids(ids)
      Array.wrap(ids).each_with_object([]) { |id, result| result << find_by_id(id) }
    end

    def get_bulk(amount, params, minimal_amount = true)
      photos = []
      page = 1
      params[:per_page] = [MAX_AMOUNT_PER_PAGE, amount].min

      if params[:tag_presence].present?
        params[:filter] = params[:tag_presence] ? 'with_tags' : 'no_tags'
      end

      while photos.size < amount
        params[:page] = page
        res_photos = search(params)[:photos]

        break if res_photos.size.zero?

        photos.concat(res_photos)
        page += 1
      end

      photos = photos.take(amount)
      raise 'Not enough photos! Change search criteria or lower expected amount' \
        if minimal_amount.present? && photos.size < amount

      {
        photos: photos.map(&:symbolize_keys),
        amount: photos.size
      }
    end

    def get_packs(params)
      packs_amount = params[:packs_amount]
      photos_per_pack = params[:photos_per_pack]
      total_amount = packs_amount * photos_per_pack

      packs = get_bulk(total_amount, params)[:photos]
              .map { |photo| { id: photo[:id], url: photo[:preview1xUrl] } }
              .each_slice(photos_per_pack)
              .to_a

      overlap_percentage = params[:overlap_percentage] || 0
      if overlap_percentage.positive?
        pack_overlap_percentage = (photos_per_pack.to_f * overlap_percentage.to_f / 100)
                                  .round

        packs = packs.map do |pack|
          pack_overlap_percentage.times { |num| pack[num] = packs[0][num] }
          pack
        end
      end

      packs
    end

    def upsert_tags(params)
      photo_id = params[:photo_id]

      tags = by_ids(photo_id)
             .first[:tags]
             .map { |tag| tag['title'] }
             .concat(params[:tags])
             .uniq
             .map { |tag| { name: tag } }

      client.put do |req|
        req.url "#{photo_id}/tags"
        req.body = { tags: tags }
        req.headers['api-key'] = ENV['REMOTE_API_KEY']
      end
    end

    private

    def find_by_id(id)
      client.get(id).body.slice(*FIELDS).symbolize_keys
    end

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
