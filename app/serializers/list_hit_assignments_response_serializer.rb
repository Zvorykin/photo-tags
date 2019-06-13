# frozen_string_literal: true

class ListHitAssignmentsResponseSerializer < Blueprinter::Base
  fields :num_results, :next_token

  association :assignments, blueprint: MturkAssignmentSerializer
end