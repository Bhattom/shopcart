class AddDescToCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :desc, :text
  end
end
