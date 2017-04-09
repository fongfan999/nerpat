class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :major, optional: true
  belongs_to :school, optional: true

  validates :username, presence: true, length: { minimum: 4, maximum: 15 },
    format: {with: /\A\w{4,15}\z/}

  def find_by_username(usn)
    self.username == usn ? self : nil
  end
end
