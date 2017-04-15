class RenameAvatarImageToAvatarFromProfiles < ActiveRecord::Migration[5.0]
  def up
    remove_attachment :profiles, :avatar_image
    add_attachment :profiles, :avatar
  end

  def down
    remove_attachment :profiles, :avatar
    add_attachment :profiles, :avatar_image
  end
end
