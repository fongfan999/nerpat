class AnswersController < ApplicationController
  before_action :authenticate_user
  before_action :build_answer, only: :create
  before_action :set_answer, except: :create

  def create
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
    def build_answer
      @question = Question.find(params[:question_id]) 
      @answer = Answer.new(answer_params)
      @answer.assign_attributes(question: @question, user: current_user)
      authorize @answer
    end

    def set_answer
      @answer = Answer.find(params[:id])
      authorize @answer
    end

    def answer_params
      params.require(:answer).permit(:content)
    end
end
