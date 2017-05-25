class MoveAvatarFromProfilesToUsers < ActiveRecord::Migration[5.0]
  def up
    remove_attachment :profiles, :avatar
    add_attachment :users, :avatar
  end

  def down
    remove_attachment :users, :avatar
    add_attachment :profiles, :avatar
  end
end
