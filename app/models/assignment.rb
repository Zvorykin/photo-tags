# frozen_string_literal: true

class Assignment
  include Mongoid::Document

  field :assignment_id, type: String
  validates :assignment_id, presence: true, uniqueness: true

  field :hit_id, type: String
  validates :hit_id, presence: true, uniqueness: true

  field :status, type: String
  validates :status, inclusion: { in: %w[Submitted Approved Rejected] }

  field :answers, type: Array
  validates :answers, presence: true

  field :results, type: Array, default: []

  field :submit_time, type: DateTime
  validates :submit_time, presence: true

  field :payload, type: Hash

  after_save do |document|
    document[:results]
      .filter { |result| result[:applied] }
      .each_with_object([]) { |result, tag_list| tag_list.concat(result[:tags]) }
      .uniq
      .each { |tag| PhotoTag.new(name: tag).upsert }
  end
end
