class Vote < ApplicationRecord
  enum flag: { up: true, down: false }
  
  belongs_to :user
  belongs_to :votable, polymorphic: true
end