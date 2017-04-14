class QuestionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group
  before_action :set_question, only: [:edit, :update]
  before_action :patron_or_own_authorization, only: :destroy
  

  def new
    @question = Question.new
  end

  def show
    @question = @group.questions.find(params[:id])
  end

  def create
    @question = @group.questions.build(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = "Đặt câu hỏi thành công"
      redirect_to @group
    else
      flash.now[:alert] = "Lỗi đặt câu hỏi"
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:notice] = "Cập nhật câu hỏi thành công";
       redirect_to group_question_path
    else
      flash.now[:alert] = "Lỗi đặt câu hỏi"
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:alert] = "Xóa câu hỏi thành công"
    redirect_to @group
  end

  private
    def set_group
      @group = current_user.groups.find(params[:group_id])
    end

    def set_question
      @question = current_user.questions.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end

    def patron_or_owned_authorization
      @question = @group.questions.find(params[:id])
      if !@question.user == current_user || !@group.patron == current_user
        flash[:alert] =  "Bạn không có quyền xóa câu hỏi."
        redirect_to @group
      end
    end
end
 