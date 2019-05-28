# frozen_string_literal: true

class HitSerializer < Blueprinter::Base
  fields :hit_id,
         :title,
         :description,
         :creation_time,
         :question,
         :hit_status,
         :max_assignments,
         :reward,
         :auto_approval_delay_in_seconds,
         :expiration,
         :assignment_duration_in_seconds,
         :hit_review_status,
         :number_of_assignments_pending,
         :number_of_assignments_available,
         :number_of_assignments_completed
end