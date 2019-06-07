# frozen_string_literal: true

class ImageSerializer < Blueprinter::Base
  identifier(:id) { |image| image.id.to_s }

  fields :filename,
   :original_uri

end