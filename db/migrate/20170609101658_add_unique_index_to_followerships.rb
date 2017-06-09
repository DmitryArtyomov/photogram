class AddUniqueIndexToFollowerships < ActiveRecord::Migration[5.0]
  def change
    add_index :followerships, [:follower_id, :followed_id], unique: true
  end
end
