class CreateJoinTableAlbumTags < ActiveRecord::Migration[5.0]
  def change
    create_join_table :albums, :tags do |t|
      t.index [:album_id, :tag_id]
      t.index [:tag_id, :album_id]
    end
  end
end
