# frozen_string_literal: true

class HitSerializer < Blueprinter::Base
  identifier(:id) { |hit| hit.id.to_s }

  fields :mturk_id,
         :title,
         :description,
         :created_at,
         :expiration_at,
         :status,
         :max_assignments,
         :reward,
         # :auto_approval_delay_in_seconds,
         # :assignment_duration_in_seconds,
         :assignment_duration
    # :hit_review_status,
    # :number_of_assignments_pending,
    # :number_of_assignments_available,
    # :number_of_assignments_completed
end