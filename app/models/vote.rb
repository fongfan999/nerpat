class Vote < ApplicationRecord
  enum flag: { up: true, down: false }
  
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def self.create_vote(record, user)
    where(user: user, votable: record).first_or_create
  end

  def change_vote(type)
    self.send("#{type}!")
  end
end