class QuestionsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :set_group
  before_action :set_question, only: [:edit, :update]
  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
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

  private
    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_question
      @question = current_user.questions.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end
end
 