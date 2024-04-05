class AddPincodeToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :pincode, :integer
  end
end
