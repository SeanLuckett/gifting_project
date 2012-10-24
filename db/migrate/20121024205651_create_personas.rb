class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
