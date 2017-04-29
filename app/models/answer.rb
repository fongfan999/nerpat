class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable

  validates :content, presence: true, length: {minimum: 6}

  delegate :group, to: :question

  def count_votes(type)
    votes.where(flag: type).count
  end
end
