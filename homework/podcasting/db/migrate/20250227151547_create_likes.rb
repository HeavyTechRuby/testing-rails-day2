class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.integer :episode_id
      t.integer :user_id

      t.timestamps
    end
  end
end
