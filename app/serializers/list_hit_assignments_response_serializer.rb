# frozen_string_literal: true

class ListHitAssignmentsResponseSerializer < Blueprinter::Base
  fields :num_results, :next_token, :assignment_status

  association :assignments, blueprint: MturkAssignmentSerializer
end