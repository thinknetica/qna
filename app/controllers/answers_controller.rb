class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html {render @answer}
      else
        format.html do
          render partial: 'shared/errors', locals: { resource: @answer },
                              status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body, links_attributes: [:name, :url])
  end
end