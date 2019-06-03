# frozen_string_literal: true

class QuestionController < ActionController::Base
  def show
    result = QuestionService.new(html_only: true).question

    render inline: result
  end
end
