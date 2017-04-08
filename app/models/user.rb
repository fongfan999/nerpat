class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  belongs_to :patron, class_name: 'User', required: false
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

  private

  def check_limitation(nerge)
    raise 'Nerges Limitation' if nerges.count >= 6
  end
end
