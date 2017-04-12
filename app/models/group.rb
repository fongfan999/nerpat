class Group < ApplicationRecord
  belongs_to :patron, class_name: "User"
  has_many :memberships
  has_many :users, through: :memberships

  def name
    super || "Group #{id}"
  end
end
