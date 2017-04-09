class AddUsernameToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :username, :string
  end
end
