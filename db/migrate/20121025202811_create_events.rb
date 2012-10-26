class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.date :date, :null => false
      t.integer :user_id
      t.boolean :repeats, :default => true

      t.timestamps
    end
  end
end
