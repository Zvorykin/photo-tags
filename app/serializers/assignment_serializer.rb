# frozen_string_literal: true

class AssignmentSerializer < Blueprinter::Base
  fields :hit_id,
         :assignment_id,
         :status,
         :submit_time,
         :answers,
         :results
end