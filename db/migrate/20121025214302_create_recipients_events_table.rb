class CreateRecipientsEventsTable < ActiveRecord::Migration
  def up
    create_table :events_recipients, :id => false do |t|
      t.references :event
      t.references :recipient
    end

    add_index :events_recipients, [:recipient_id, :event_id]
    add_index :events_recipients, [:event_id, :recipient_id]
  end

  def down
    drop_table :events_recipients
  end
end
