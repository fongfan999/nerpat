class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(google_uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.avatar = auth.info.image
      user.google_uid = auth.uid
    end
  end
end
