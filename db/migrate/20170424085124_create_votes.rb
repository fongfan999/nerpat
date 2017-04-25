class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.boolean :flag
      t.references :user, foreign_key: true
      t.string :votable_type
      t.integer :votable_id
    end

    add_index :votes, [:votable_id, :votable_type]
  end
end
