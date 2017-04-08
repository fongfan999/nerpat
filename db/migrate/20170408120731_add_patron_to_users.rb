class AddPatronToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :patron, index: true
  end
end
