# frozen_string_literal: true

class QuestionService
  HTML_REGEX = /<!DOCTYPE html>.*<\/html>/m.freeze

  attr_reader :html_only, :max_tags_amount

  def initialize(params = {})
    @html_only = params[:html_only] || false
    @max_tags_amount = params[:max_tags_amount] || 10
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
    template = File.open(template_path, 'rb', &:read)
    ERB.new(template).result(binding)
  end

  def template_path
    @template_path ||= Rails.root.join('app', 'templates', 'question.html.erb')
  end

  def autocomplete_js
    file_path = autocomplete_path.join('autocomplete.min.js')
    @autocomplete_js ||= File.open(file_path, 'rb', &:read)
  end

  def autocomplete_css
    file_path = autocomplete_path.join('autocomplete.css')
    @autocomplete_css ||= File.open(file_path, 'rb', &:read)
  end

  def autocomplete_path
    Rails.root.join('vendor', 'autocomplete')
  end

  def external_hit_js
    file_path = Rails.root.join('vendor', 'mturk', 'external_hit_v1.js')
    @external_hit_js ||= File.open(file_path, 'rb', &:read)
  end

  def min_tags_amount
    1
  end

  def images
    [
      {
        id: 1,
        url: 'https://media.pitchfork.com/photos/592c558f0c2bba1b7de04626/2:1/w_790/d432faf1.jpg'
      },
      {
        id: 2,
        url: 'https://news784.com/wp-content/uploads/2019/04/sunrise-678x381.png'
      }
    ]
  end

  def tags
    const_tags = [
      'cat',
      'lemmy',
      'sunset'
    ]

    50.times { const_tags << ('a'..'z').to_a.sample(20).join }

    const_tags.sort
  end

  def input_names(id)
    result = []
    max_tags_amount.times { |num| result << "input-#{num + 1}-#{id}" }
    result
  end

  def images_input_names
    images.each_with_object({}) do |image, result|
      id = image[:id]
      result[id] = input_names(id)
    end
  end
end
