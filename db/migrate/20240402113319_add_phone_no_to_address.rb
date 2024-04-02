class AddPhoneNoToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :phone_no, :integer
  end
end
