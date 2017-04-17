class AnswersController < ApplicationController
  before_action :authenticate_user
  before_action :set_question
  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.build(params.require(:answer).permit(:content))
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Trả lời thành công"
      redirect_to @question
    else
      flash.now[:alert] = "Không trả lời được"
      render :new
    end
  end

  private
    def set_question
      @question = current_user.questions.find(params[:question_id])
    end
end
