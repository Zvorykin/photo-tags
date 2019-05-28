class Photo
  include Mongoid::Document

  field :name, type: String
  field :url, type: String

  validates :name, presence: true, uniqueness: true

  embeds_many :tags
end
