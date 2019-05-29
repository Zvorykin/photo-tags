class QuestionService
  def initialize; end

  def build_question
    template = File.open(template_path, 'rb', &:read)
    ERB.new(template).result(binding)
  end

  private

  def template_path
    @template_path ||= Rails.root.join('app', 'templates', 'question.html.erb')
  end

end
