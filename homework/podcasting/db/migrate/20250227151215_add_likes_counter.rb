class AddLikesCounter < ActiveRecord::Migration[8.0]
  def change
    add_column :episodes, :likes_count, :integer
  end
end
