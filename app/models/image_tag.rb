# frozen_string_literal: true

class PhotoTag
  include Mongoid::Document
  
  field :name, type: String
  validates :name, presence: true, uniqueness: true
end
