class QuestionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group, only: [:new, :create]
  before_action :set_question, except: [:new, :create]

  def show
    @answer = Answer.new
  end

  def new
    @question = @group.questions.build
    authorize @question
  end

  def create
    @question = @group.questions.build(question_params)
    @question.user = current_user
    authorize @question

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
    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_question
      @question = Question.find(params[:id])
      authorize @question
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end
end
