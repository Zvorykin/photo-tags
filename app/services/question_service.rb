# frozen_string_literal: true

class QuestionService
  HTML_REGEX = /<!DOCTYPE html>.*<\/html>/m.freeze

  attr_reader :html_only, :max_tags_amount, :tags

  def initialize(params = {})
    @html_only = params[:html_only] || false
    @max_tags_amount = params[:max_tags_amount] || 10
    @photos = params[:photos]
    @tags = params[:tags] || []
  end

  def question
    result = build_question

    if @html_only
      result[HTML_REGEX, 0]
    else
      result
    end
  end

  private

  def build_question
    template = File.open(template_path, 'r', &:read)
    ERB.new(template).result(binding)
  end

  def template_path
    @template_path ||= Rails.root.join('app', 'templates', 'question.html.erb')
  end

  def tagify_js
    file_path = tagify_path.join('tagify.min.js')
    @tagify_js ||= File.open(file_path, 'r', &:read)
  end

  def tagify_js_polyfill
    file_path = tagify_path.join('tagify.polyfills.min.js')
    @tagify_js_polyfill ||= File.open(file_path, 'r', &:read)
  end

  def tagify_css
    file_path = tagify_path.join('tagify.css')
    @tagify_css ||= File.open(file_path, 'r', &:read)
  end

  def tagify_path
    Rails.root.join('vendor', 'tagify')
  end

  def external_hit_js
    file_path = Rails.root.join('vendor', 'mturk', 'external_hit_v1.js')
    @external_hit_js ||= File.open(file_path, 'r', &:read)
  end

  def min_tags_amount
    1
  end

  def photos
    if Rails.env.development? && @photos.nil?
      @photos = [
        {
          id: '5ac23fd28b65880001e4b29d',
          url: 'https://photo-cdn.icons8.com/assets/previews/744/d6be7777-9c2c-4628-8edb-6e928e3313a81x.jpg'
        },
        {
          id: '5b630a448b65880001bbd7c4',
          url: 'https://photo-cdn.icons8.com/assets/previews/344/e1aa78c4-7179-4e79-b04b-3909b2f654921x.jpg'
        },
        {
          id: '5cda92cc0809980001c21cd0',
          url: 'https://photo-cdn.icons8.com/assets/previews/220/722c033a-f1b4-4a8e-b4f2-32a85e9003f31x.jpg'
        }
      ]
    end

    @photos
  end
end
