class CreateLineitemSizes < ActiveRecord::Migration[7.1]
  def change
    create_table :lineitem_sizes do |t|
      t.references :lineitem, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
