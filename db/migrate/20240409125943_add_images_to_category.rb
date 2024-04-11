class AddImagesToCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :images, :json
  end
end
