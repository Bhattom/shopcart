class AddTrackToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :track, :integer
  end
end
