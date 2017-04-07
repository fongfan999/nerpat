class User < ApplicationRecord

  def self.from_omniauth(auth)
    where(auth.permit(:provider, :uid)).first_or_create do |user|
      user.name = auth.info.name
      user.avatar = auth.info.image
      user.google_uid = auth.uid
      user.save!
    end
  end
end
