class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true, optional: true

  scope :nerpat_requests, -> do
    where(notifiable_type: "User")
    .where("action = ? OR action = ?",
      "muốn nhận bạn làm Nerge", "muốn nhận bạn làm Patron")
  end

  scope :unread, -> { where(read_at: nil) }

  def nerge_request?
    action == "muốn nhận bạn làm Nerge"
  end
end
