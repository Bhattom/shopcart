class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items do |t|

      t.timestamps
    end
  end
end
