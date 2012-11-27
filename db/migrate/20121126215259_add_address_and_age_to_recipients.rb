class AddAddressAndAgeToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :age, :string
    
    add_column :recipients, :address1, :string
    add_column :recipients, :address2, :string
    add_column :recipients, :state, :string, :limit => 2
    add_column :recipients, :city, :string
    add_column :recipients, :zip_code, :string
  end
end
