class AddImagesToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :images, :json
  end
end
