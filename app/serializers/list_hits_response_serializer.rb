class ListHitsResponseSerializer < Blueprinter::Base
  fields :next_token, :num_results

  association :hits, blueprint: HitSerializer
end

