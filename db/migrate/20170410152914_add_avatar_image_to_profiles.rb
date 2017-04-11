class AddAvatarImageToProfiles < ActiveRecord::Migration[5.0]
  def up
    add_attachment :profiles, :avatar_image
  end

  def down
    remove_attachment :profiles, :avatar_image
  end
end
