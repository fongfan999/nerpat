class AddSchoolIdToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_reference :profiles, :school, foreign_key: true
  end
end
