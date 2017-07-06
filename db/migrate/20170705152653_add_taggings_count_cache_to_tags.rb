class AddTaggingsCountCacheToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :taggings_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE tags
      SET taggings_count = (SELECT count(1) FROM taggings WHERE taggings.tag_id = tags.id);
    SQL
  end
end
