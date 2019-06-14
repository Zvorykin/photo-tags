# frozen_string_literal: true

class MturkAssignmentSerializer < Blueprinter::Base
  fields :hit_id,
         :assignment_id,
         :assignment_status,
         :auto_approval_time,
         :accept_time,
         :submit_time,
         :approval_time,
         :rejection_time,
         :deadline,
         :answers,
         :requester_feedback
end