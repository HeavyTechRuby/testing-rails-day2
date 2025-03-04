class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :podcast_id

      t.timestamps
    end
  end
end
