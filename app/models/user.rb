class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  after_create :create_profile_with_username

  def self.from_omniauth(auth)
    if auth.info.email =~ /edu\.vn\z/
      where(google_uid: auth.uid).first_or_create do |user|
        user.name = auth.info.name
        user.avatar = auth.info.image
        user.google_uid = auth.uid
        user.student_id = auth.info.email[/\d+/]
      end
    end
  end


  def create_profile_with_username
    create_profile(username: student_id)
  end

  def own?(profile)
    self.profile == profile
  end
end
