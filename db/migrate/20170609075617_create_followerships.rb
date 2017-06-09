class CreateFollowerships < ActiveRecord::Migration[5.0]
  def change
    create_table :followerships do |t|
      t.references :follower, index: true, foreign_key: { to_table: :users, on_delete: :cascade }
      t.references :followed, index: true, foreign_key: { to_table: :users, on_delete: :cascade }

      t.timestamps
    end
  end
end
