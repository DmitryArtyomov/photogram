class ModifyForeignKeysForComment < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :comments, :users
    remove_foreign_key :comments, :photos
    add_foreign_key :comments, :users,  on_delete: :cascade
    add_foreign_key :comments, :photos, on_delete: :cascade
  end
end
