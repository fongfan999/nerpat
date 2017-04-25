class VotesController < ApplicationController
  before_action :authenticate_user
  before_action :set_question, only: [:upvote_question, :downvote_question]
  before_action :set_question_vote,  only: [:upvote_question, :downvote_question]
  before_action :set_answer, only: [:upvote_answer, :downvote_answer]
  before_action :set_answer_vote,  only: [:upvote_answer, :downvote_answer]
  def upvote_question
    @vote.change_vote("up")
    flash[:notice] = "Upvote thành công"
    redirect_to @question
  end

  def downvote_question
    @vote.change_vote("down")
    flash[:notice] = "Downvote thành công"
    redirect_to @question
  end

  def upvote_answer
    @vote.change_vote("up")
    flash[:notice] = "Upvote thành công"
    redirect_to @answer.question
  end

  def downvote_answer
    @vote.change_vote("down")
    flash[:notice] = "Downvote thành công"
    redirect_to @answer.question
  end
  private
    # Question
    def set_question
      @question = Question.find(params[:question_id])
      authorize @question, :create?
    end

    def set_question_vote
      @vote = Vote.create_vote(@question, current_user)
    end

    # Answer
    def set_answer
      @answer = Answer.find(params[:answer_id])
      authorize @answer, :create?
    end
    
    def set_answer_vote
      @vote = Vote.create_vote(@answer, current_user)
    end
end
