class Notification < ApplicationRecord
  default_scope { order(created_at: :desc) }
  
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true, optional: true

  scope :nerpat_requests, -> do
    where("action = ? OR action = ?",
      "muốn nhận bạn làm Nerge", "muốn nhận bạn làm Patron")
  end
  scope :without_nerpat_requests, -> do
    where.not(action: ["muốn nhận bạn làm Nerge", "muốn nhận bạn làm Patron"])
  end
  scope :unread, -> { where(read_at: nil) }

  def self.mark_as_read
    update_all(read_at: Time.current)
  end

  def nerge_request?
    action == "muốn nhận bạn làm Nerge"
  end
end
