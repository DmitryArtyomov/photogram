class AddPhotosCountCacheToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :photos_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE albums
      SET photos_count = (SELECT count(1) FROM photos WHERE photos.album_id = albums.id);
    SQL
  end
end
