class AddFollowersCountCacheToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :followers_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE users
      SET followers_count = (SELECT count(1) FROM followerships WHERE followerships.followed_id = users.id);
    SQL
  end
end
