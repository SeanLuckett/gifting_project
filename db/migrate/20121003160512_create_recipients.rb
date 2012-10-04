class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :fb_id
      t.string :name
      t.string :image
      t.date :birthday

      t.timestamps
    end
  end
end
