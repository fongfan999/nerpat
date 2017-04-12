class AddPatronIdToGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :groups, :patron
    add_foreign_key :groups, :users, column: :patron_id
  end
end

