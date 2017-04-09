class User < ApplicationRecord
  MAXIMUM_OF_NERGES = 6

  has_one :profile, dependent: :destroy
  belongs_to :patron, class_name: 'User', optional: true
  has_many :nerges, class_name: 'User', foreign_key: 'patron_id',
    before_add: :check_limitation

  after_create :create_profile

  def self.from_omniauth(auth)
    if auth.info.email =~ /edu\.vn\z/
      where(google_uid: auth.uid).first_or_create do |user|
        user.name = auth.info.name
        user.avatar = auth.info.image
        user.google_uid = auth.uid
      end
    end
  end

  def available_patrons
    return User.none if self.patron

    # Select patrons who have already reached maximum of nerges
    restricted_patron_ids = User.where.not(patron_id: nil).group('patron_id')
      .having("count_all >= #{MAXIMUM_OF_NERGES}").count.keys

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

  private

  def check_limitation(nerge)
    raise 'Nerges Limitation' if nerges.count >= 6
  end
end
