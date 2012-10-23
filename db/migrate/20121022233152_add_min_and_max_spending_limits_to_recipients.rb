class AddMinAndMaxSpendingLimitsToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :spend_at_least, :integer
    add_column :recipients, :spend_at_most, :integer
  end
end
