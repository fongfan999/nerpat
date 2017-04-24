class Question < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :answers, dependent: :destroy

  validates :title, presence: true

  def count_answers
    answers.count
  end
end
