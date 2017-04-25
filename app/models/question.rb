class Question < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable

  validates :title, presence: true

  def count_answers
    answers.count
  end

  def count_votes(type)
    votes.where(flag: type).count
  end
end
