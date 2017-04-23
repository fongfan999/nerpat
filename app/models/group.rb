class Group < ApplicationRecord
  belongs_to :patron, class_name: "User"
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :questions, dependent: :destroy

  validates :name, presence: true, length: {minimum: 6, maximum: 150}

  def name
    super || "Group #{id}"
  end

  def has_member?(user)
    users.exists? user.id
  end
end
