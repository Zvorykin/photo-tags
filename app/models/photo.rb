# frozen_string_literal: true

class Photo
  include Mongoid::Document
  store_in client: 'moose'

  field :filename, type: String
  field :original_uri, type: String

  validates :filename, presence: true, uniqueness: true
  validates :original_uri, presence: true, uniqueness: true

  embeds_many :tags
end
