class AnswersController < ApplicationController
  before_action :authenticate_user
  before_action :set_question, only: :create
  before_action :set_answer, only: [:edit, :update]
  before_action :check_answer_owner_or_patron_authorization, only: :destroy

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Trả lời thành công"
      redirect_to @question
    else
      flash.now[:alert] = "Câu trả lời không hợp lệ"
      render "questions/show"
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      flash[:notice] = "Cập nhật câu trả lời thành công"
      redirect_to @answer.question
    else
      flash.now[:alert] = "Câu trả lời không hợp lệ"
      render :edit
    end
  end

  def destroy
    @answer.destroy
    flash[:notice] = "Xóa câu trả lời thành công"
    redirect_to root_path
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = current_user.answers.find(params[:id])
    end

    def check_answer_owner_or_patron_authorization
      @answer = Answer.find(params[:id])
      if current_user.cannot_destroy?(@answer)
        flash[:alert] = "Bạn không có quyền xóa câu trả lời"
        redirect_to root_path
      end
    end

    def answer_params
      params.require(:answer).permit(:content)
    end
    
end
