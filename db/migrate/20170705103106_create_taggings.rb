class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings, id: false do |t|
      t.references :tag, foreign_key: { on_delete: :cascade }
      t.references :taggable, polymorphic: true
    end

    add_index :taggings, [:tag_id, :taggable_id, :taggable_type], unique: true
  end
end
