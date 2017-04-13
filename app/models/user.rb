class User < ApplicationRecord
  MAXIMUM_OF_NERGES = 6

  has_one :profile, dependent: :destroy
  belongs_to :patron, class_name: 'User', optional: true
  has_many :nerges, class_name: 'User', foreign_key: 'patron_id',
    before_add: :check_nerges_limitation, after_add: :add_nerge_to_group
  has_many :notifications, as: :notifiable, foreign_key: 'recipient_id',
    dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships, before_add: :check_groups_limitation

  after_create :create_profile_with_username
  after_update :remove_nerge_from_group, if: Proc.new { |n| n.patron.nil? }

  def self.from_omniauth(auth)
    info = auth.info
    if info.email =~ /edu\.vn\z/
      where(google_uid: auth.uid).first_or_create do |user|
        user.first_name = info.first_name
        user.last_name = info.last_name
        user.google_uid = auth.uid
        user.student_id = info.email[/\d+/]
      end
    end
  end

  def full_name
    last_name + ' ' + first_name
  end

  def available_patrons
    return User.none if self.patron

    # Select patrons who have already reached maximum of nerges
    restricted_patron_ids = User.where.not(patron_id: nil)
      .group(:patron_id)
      .having("COUNT(*) >= #{MAXIMUM_OF_NERGES}")
      .pluck(:patron_id)

    # Their nerges cannot be their patrons
    restricted_patron_ids += nerge_ids

    User.where.not(id: self).where.not(id: restricted_patron_ids)
  end

  def available_nerges
    return User.none if self.nerges.count >= MAXIMUM_OF_NERGES

    User.where.not(id: self)
      .where.not(id: self.patron) # Patron cannot be a nerge at the same time
      .where(patron_id: nil) # Any users have no patron can be a nerge
  end

  def own?(profile)
    self.profile == profile
  end

  def send_nerpat_request_to(recipient, action)
    Notification.find_or_create(actor: self, recipient: recipient,
      action: action, notifiable_type: "User")
  end

  private

  def check_nerges_limitation(nerge)
    raise 'Nerges Limitation' if nerges.count >= 6
  end

  def check_groups_limitation(group)
   raise 'Groups Limitation' if groups.count >= 2
  end

  def add_nerge_to_group(nerge)
    group = Group.find_or_create_by(patron_id: self.id)
    group.users << self unless group.users.exists?(self.id)
    group.users << nerge
  end

  def remove_nerge_from_group
    group = self.groups.where.not(patron: self).first
    group.users.destroy(self)
  end

  def create_profile_with_username
    create_profile(username: student_id)
  end
end
