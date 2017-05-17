class VotesController < ApplicationController
  before_action :authenticate_user

  def upvote
    vote("up")
  end

  def downvote
    vote("down")
  end

  private
    def get_votable
      if request.path =~ %r{\A/questions/\d+}
        Question.find(params[:id])
      elsif request.path =~ %r{\A/answers/\d+}
        Answer.find(params[:id])
      end
    end

    def vote(type)
      record = get_votable
      authorize record

      if current_user.change_vote(record, type)
        redirect_to record.votable_path, notice: "#{type} thành công"
      else
        redirect_to record.votable_path, notice: "Bạn không thể #{type}"
      end
    end
end
