# frozen_string_literal: true

class QuestionController < ActionController::Base
  def show
    tags = %w[cat dog girl man]
    result = QuestionService.new(html_only: true, tags: tags).question

    render inline: result
  end
end
