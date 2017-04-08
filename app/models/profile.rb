class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :major, optional: true
end
