class User < ApplicationRecord
  MAXIMUM_OF_NERGES = 6

  has_one :profile, dependent: :destroy
  belongs_to :patron, class_name: 'User', optional: true
  has_many :nerges, class_name: 'User',
    foreign_key: 'patron_id',
    before_add: :check_nerges_limitation,
    after_add: :add_nerge_to_group
  has_many :notifications, as: :notifiable,
    foreign_key: 'recipient_id',
    dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships,
    before_add: :check_groups_limitation
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  after_create :create_profile_with_username
  after_update :remove_nerge_from_group, if: Proc.new { |n| n.patron.nil? }

  scope :exclude_requested_nerpaters, -> (user) do
    where.not(id: user.notifications.nerpat_requests.pluck(:actor_id))
  end

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

  def available_nerges
    return User.none if self.nerges.count >= MAXIMUM_OF_NERGES

    # Do not include self of course
    restricted_nerge_ids = [self.id]
    # Patron cannot be a nerge at the same time (if self have)
    restricted_nerge_ids << self.patron.id if self.patron

    User.where(patron_id: nil) # Any users have no patron can be a nerge
      .where.not(id: restricted_nerge_ids.uniq)
  end

  def available_patrons
    return User.none if self.patron

    # Do not include self of course
    restricted_patron_ids = [self.id]
    # Select patrons who have already reached maximum of nerges
    restricted_patron_ids += User.where.not(patron_id: nil)
      .group(:patron_id)
      .having("COUNT(*) >= #{MAXIMUM_OF_NERGES}")
      .pluck(:patron_id)

    # Their nerges cannot be their patrons
    restricted_patron_ids += nerge_ids

    User.where.not(id: restricted_patron_ids.uniq)
  end

  def own?(profile)
    self.profile == profile
  end
  
  def group_as_patron_role
    groups.where.not(patron_id: nil).first
  end

  def group_as_nerge_role
    groups.where(patron_id: nil).first
  end

  def is_patron?(group)
    group.patron == self
  end

  def is_author?(record)
    record.user == self
  end

  def cannot_destroy?(record)
    !(is_patron?(record.group) || is_author?(record))
  end
 
  def pending_nerpats
    ids = Notification.nerpat_requests.where(actor: self).pluck(:recipient_id)
    User.where(id: ids)
  end

  def requested_nerpats
    ids = notifications.nerpat_requests.pluck(:actor_id)
    User.where(id: ids)
  end

  def nerge_request_with?(user)
    Notification.where(actor: self, recipient: user,
      action: "muốn nhận bạn làm Nerge").first
  end

  def nerpat_request_to(recipient, action)
    recipient.notifications.find_or_create_by(actor: self, action: action)
  end

  def accept_nerge_request_from(patron)
    if decline_nerge_request_from(patron)
      patron.nerges << self
      patron.notifications.create(actor: self,
        action: "đã đồng ý nhận bạn làm Patron")
    end
  end

  def decline_nerge_request_from(patron)
    notifications
      .where(actor: patron, action: "muốn nhận bạn làm Nerge").first.destroy  
  rescue
    nil
  end

  def accept_patron_request_from(nerge)
    if decline_patron_request_from(nerge)
      nerges << nerge
      nerge.notifications.create(actor: self,
        action: "đã đồng ý nhận bạn làm Nerge")
    end
  end

  def decline_patron_request_from(nerge)
    notifications
      .where(actor: nerge, action: "muốn nhận bạn làm Patron").first.destroy
  rescue
    nil
  end

  private

  def check_nerges_limitation(nerge)
    raise 'Nerges Limitation' if nerges.count >= MAXIMUM_OF_NERGES
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
    if group = self.groups.where.not(patron: self).first
      group.users.destroy(self)
    end
  end

  def create_profile_with_username
    create_profile(username: student_id)
  end
end
