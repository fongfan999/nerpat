class User < ApplicationRecord
  include Concerns::Nerpatship

  has_one :profile, dependent: :destroy
  has_many :notifications, as: :notifiable,
    foreign_key: 'recipient_id',
    dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships,
    before_add: :check_groups_limitation
  has_many :questions, dependent: :destroy

  after_create :create_profile_with_username
  after_update :remove_nerge_from_group, if: Proc.new { |n| n.patron.nil? }

  def self.from_omniauth(auth)
    if auth.info.email =~ /edu\.vn\z/
      where(google_uid: auth.uid).first_or_create do |user|
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.google_uid = auth.uid
        user.student_id = auth.info.email[/\d+/]
      end
    end
  end

  def full_name
    last_name + ' ' + first_name
  end

  def own?(profile)
    self.profile == profile
  end

  def own_group?(group)
    group.patron_id == id
  end

  def own_question?(question)
    question.user == self
  end

  private
  
  def check_groups_limitation(group)
   raise 'Groups Limitation' if groups.count >= 2
  end

  def remove_nerge_from_group
    if group = self.groups.where.not(patron: self).first
      group.users.destroy(self)
    end
  end

  def create_profile_with_username
    create_profile(username: student_id)
  end
end
