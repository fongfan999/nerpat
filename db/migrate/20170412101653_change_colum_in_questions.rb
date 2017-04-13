class ChangeColumInQuestions < ActiveRecord::Migration[5.0]
  def change
    change_column :questions, :body, :text
  end
end
