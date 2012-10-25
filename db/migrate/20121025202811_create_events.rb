class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.date :date, :null => false
      t.boolean :repeats, :default => false

      t.timestamps
    end
  end
end
