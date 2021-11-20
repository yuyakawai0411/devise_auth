class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.string :title, null: false
      t.string :memo, null: false
      t.references :user, null: false, foreign_key: true  
      t.timestamps
    end
  end
end
