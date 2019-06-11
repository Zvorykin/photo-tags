# frozen_string_literal: true

class Hit
  include Mongoid::Document

  field :title, type: String
  validates :title, presence: true

  field :status, type: String
  validates :status, presence: true

  field :description, type: String
  validates :description, presence: true

  field :reward, type: Float
  validates :reward, presence: true

  field :assignment_duration, type: Integer
  validates :assignment_duration, presence: true

  field :lifetime, type: Integer
  validates :lifetime, presence: true

  field :max_assignments, type: Integer
  validates :max_assignments, presence: true

  field :created_at, type: DateTime, default: Time.zone.now
  validates :created_at, presence: true

  field :expiration_at, type: DateTime
  validates :created_at, presence: true

  field :mturk_id, type: String
  validates :mturk_id, presence: true

  field :payload, type: Hash
end
