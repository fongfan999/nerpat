class Question < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable

  validates :title, presence: true, length: { minimum: 5, maximum: 150 }
  validates :body, presence: true, length: { minimum: 10 }

  def count_answers
    answers.count
  end

  def count_votes(type)
    votes.where(flag: type).count
  end
end
