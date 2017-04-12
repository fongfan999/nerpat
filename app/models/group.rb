class Group < ApplicationRecord
  belongs_to :patron, class_name: "User"
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true,length: {minimum: 6, maximum: 150}

  def name
    super || "Group #{id}"
  end
end
