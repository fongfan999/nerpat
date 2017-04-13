class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true, optional: true

  scope :nerpat_requests, -> { where(notifiable_type: "User") }
  scope :unread, -> { where(read_at: nil) }
end
