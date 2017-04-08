class AddBioToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :bio, :text
  end
end
