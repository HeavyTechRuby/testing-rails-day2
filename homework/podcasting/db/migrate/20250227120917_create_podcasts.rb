class CreatePodcasts < ActiveRecord::Migration[8.0]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.integer :author_id
      t.string :status
      t.timestamps
    end
  end
end
