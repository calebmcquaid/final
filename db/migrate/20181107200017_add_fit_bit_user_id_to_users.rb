class AddFitBitUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fitbit_user_id, :string
  end
end
