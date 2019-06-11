class Assignment
  include Mongoid::Document

  field :assignment_id, type: String
  validates :assignment_id, presence: true, uniqueness: true

  field :hit_id, type: String
  validates :hit_id, presence: true, uniqueness: true

  field :status, type: String
  validates :status, inclusion: { in: %w[Submitted Approved Rejected] }

  field :result, type: Hash
  validates :result, presence: true

  field :submit_time, type: DateTime
  validates :submit_time, presence: true

  field :payload, type: Hash
end
