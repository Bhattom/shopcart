class AddCityToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :city, :string
  end
end
