class QuestionsController < ApplicationController
  before_action :authenticate_user
  # Set question and check current user is a member of group
  before_action :set_question_show, only: :show    
  before_action :set_group, only: [:new, :create]
  before_action :set_question, only: [:edit, :update]
  before_action :check_patron_or_owner_authorization, only: :destroy

  def new
    @question = @group.questions.build
  end


  def show
    @answer = Answer.new 
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
       redirect_to question_path
    else
      flash.now[:alert] = "Lỗi đặt câu hỏi"
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = "Xóa câu hỏi thành công"
    redirect_to root_path
  end

  private
    def set_question_show
      @question = Question.find(params[:id])
      unless @question.group.has_member?current_user
        flash[:alert] = "Bạn không có quyền đọc câu hỏi này";
        redirect_to root_path
      end
    end
    
    def set_group
      @group = current_user.groups.find(params[:group_id])
    end

    def set_question
      @question = current_user.questions.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end

    def check_patron_or_owner_authorization
      @question = Question.find(params[:id])
      if current_user.cannot_destroy?(@question)
        flash[:alert] =  "Bạn không có quyền xóa câu hỏi."
        redirect_to root_path
      end
    end
end