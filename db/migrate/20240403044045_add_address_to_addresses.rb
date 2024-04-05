class AddAddressToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :address, :text
  end
end
