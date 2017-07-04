class ModifyIndexesOnTagJoinTables < ActiveRecord::Migration[5.0]
  def change
    remove_index :photos_tags, column: [:photo_id, :tag_id]
    remove_index :photos_tags, column: [:tag_id, :photo_id]
    add_index :photos_tags, [:photo_id, :tag_id], unique: true
    add_index :photos_tags, [:tag_id, :photo_id], unique: true

    remove_index :albums_tags, column: [:album_id, :tag_id]
    remove_index :albums_tags, column: [:tag_id, :album_id]
    add_index :albums_tags, [:album_id, :tag_id], unique: true
    add_index :albums_tags, [:tag_id, :album_id], unique: true
  end
end
