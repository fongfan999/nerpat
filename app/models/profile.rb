class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :major, optional: true
  belongs_to :school, optional: true
  has_many :profile_skills
  has_many :skills, through: :profile_skills

  has_attached_file :avatar, styles: { original: "300x300#" },
    default_url: "/images/profiles/missing.png"
  validates_attachment_content_type :avatar,
   content_type: /\Aimage\/.*\z/

  validates :username, presence: true, uniqueness: true,
    length: { minimum: 4, maximum: 15 },
    format: { with: /\A\w{4,15}\z/ }
  with_options presence: true, on: :update do
    validates :bio, length: { minimum: 10 }
    validates :school_id
    validates :major_id
  end

  def to_param
    username
  end
  
  def find_by_username(usn)
    self.username == usn ? self : nil
  end
end
