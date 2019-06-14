# frozen_string_literal: true

class ImageSerializer < Blueprinter::Base
  identifier(:id)

  fields :filename,
         :tags,
         :thumb1xUrl,
         :preview1xUrl

end