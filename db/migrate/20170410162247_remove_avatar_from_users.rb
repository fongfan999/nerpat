class RemoveAvatarFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :avatar, :string
  end
end
