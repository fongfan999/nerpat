class User < ApplicationRecord
  has_one :profile, dependent: :destroy
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
end
