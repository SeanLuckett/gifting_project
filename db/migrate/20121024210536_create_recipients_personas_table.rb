class CreateRecipientsPersonasTable < ActiveRecord::Migration
  # regarding descrepency 'twixt class name and table name:
  # Calling it recipients_personas caused postgres "doesn't exist" errors;
  # personas_recipients doesn't.
  def up
    create_table :personas_recipients, :id => false do |t|
      t.references :persona
      t.references :recipient
    end

    add_index :personas_recipients, [:recipient_id, :persona_id]
    add_index :personas_recipients, [:persona_id, :recipient_id]
  end

  def down
    drop_table :personas_recipients
  end
end
