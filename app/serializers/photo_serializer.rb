# frozen_string_literal: true

class PhotoSerializer < Blueprinter::Base
  identifier(:id)

  fields :filename,
         :title,
         :tags,
         :thumb1xUrl,
         :preview1xUrl

  view :with_assignment do
    fields :assignment_id,
           :assignment_tags
  end
end