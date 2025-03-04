class CreateEpisodes < ActiveRecord::Migration[8.0]
  def change
    create_table :episodes do |t|
      t.string :podcast_id
      t.string :status
      t.string :title

      t.timestamps
    end
  end
end
