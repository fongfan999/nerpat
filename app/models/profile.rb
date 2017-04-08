class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :major, optional: true

  validates :username, presence: true, length: { minimum: 4, maximum: 15 },
    format: {with: /\A\w{4,15}\z/}
  # validates :bio, presence: true, on: :update
  validates :major_id, presence: true, on: :update

  def find_by_username(usn)
    self.username == usn ? self : nil
  end
end
