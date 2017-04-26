class VotesController < ApplicationController
  before_action :authenticate_user
  before_action :set_question,  only: [:upvote_question, :downvote_question]
  before_action :set_answer,  only: [:upvote_answer, :downvote_answer]
  
  def upvote_question
    if current_user.change_vote(@question, "up")
      flash[:notice] = "Upvote thành công"
      redirect_to @question
    else 
      flash[:alert] = "Bạn không thể upvote"
      redirect_to @question
    end
  end

  def downvote_question
    if current_user.change_vote(@question, "down")
      flash[:notice] = "Downvote thành công"
      redirect_to @question
    else 
      flash[:alert] = "Bạn không thể downvote"
      redirect_to @question
    end
  end

  def upvote_answer
    if current_user.change_vote(@answer, "up")
      flash[:notice] = "Upvote thành công"
      redirect_to @answer.question
    else 
      flash[:alert] = "Bạn không thể upvote"
      redirect_to @answer.question
    end
  end

  def downvote_answer
    if current_user.change_vote(@answer, "down")
      flash[:notice] = "Upvote thành công"
      redirect_to @answer.question
    else 
      flash[:alert] = "Bạn không thể upvote"
      redirect_to @answer.question
    end
  end
  private
    # Question
    def set_question
      @question = Question.find(params[:question_id])
      authorize @question, :create?
    end

    # Answer  
    def set_answer
      @answer = Answer.find(params[:answer_id])
      authorize @answer, :create?
    end
end
