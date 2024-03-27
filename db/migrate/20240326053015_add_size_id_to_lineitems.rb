class AddSizeIdToLineitems < ActiveRecord::Migration[7.1]
  def change
    add_reference :lineitems, :size, foreign_key: true
  end
end
