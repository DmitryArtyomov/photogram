class DeleteTagsJoinTables < ActiveRecord::Migration[5.0]
  def change
    drop_join_table :photos, :tags do |t|
      t.index [:photo_id, :tag_id]
      t.index [:tag_id, :photo_id]
    end

    drop_join_table :albums, :tags do |t|
      t.index [:album_id, :tag_id]
      t.index [:tag_id, :album_id]
    end
  end
end
