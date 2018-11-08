class AddUserTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_token, :string
  end
end
