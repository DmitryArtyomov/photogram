class MoveTaggingsDataFromJoinTablesToPolymorphic < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      INSERT INTO taggings (tag_id, taggable_id, taggable_type)
      SELECT tag_id, photo_id, 'Photo' FROM photos_tags
      UNION ALL
      SELECT tag_id, album_id, 'Album' FROM albums_tags;

      DELETE FROM photos_tags;
      DELETE FROM albums_tags;
    SQL
  end

  def down
    execute <<-SQL.squish
      INSERT INTO photos_tags (tag_id, photo_id)
      SELECT tag_id, taggable_id FROM taggings
      WHERE taggable_type='Photo';

      INSERT INTO albums_tags (tag_id, album_id)
      SELECT tag_id, taggable_id FROM taggings
      WHERE taggable_type='Album';

      DELETE FROM taggings;
    SQL
  end
end
