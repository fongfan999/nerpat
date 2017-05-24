class VotesController < ApplicationController
  before_action :authenticate_user
  before_action :set_votable

  def upvote
    authorize @record
    vote("up")
  end

  def downvote
    authorize @record
    vote("down")
  end

  private
    def set_votable
      @record = if request.path =~ %r{\A/questions/\d+}
        Question.find(params[:id])
      elsif request.path =~ %r{\A/answers/\d+}
        Answer.find(params[:id])
      end
    end

    def vote(type)
      if current_user.change_vote(@record, type)
        redirect_to @record.votable_path, notice: "#{type} thành công"
      else
        redirect_to @record.votable_path, alert: "Đã xảy ra lỗi"
      end
    end
end
