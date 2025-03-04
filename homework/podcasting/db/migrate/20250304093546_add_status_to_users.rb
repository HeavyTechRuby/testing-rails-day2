class AddStatusToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :status, :string
  end
end
