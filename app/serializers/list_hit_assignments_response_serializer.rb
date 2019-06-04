# frozen_string_literal: true

class ListHitAssignmentsResponseSerializer < Blueprinter::Base
  fields :num_results, :next_token, :assignment_statuses

  association :assignments, blueprint: AssignmentSerializer
end