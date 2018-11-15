class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end