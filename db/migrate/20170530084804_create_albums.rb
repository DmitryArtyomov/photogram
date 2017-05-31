class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.boolean :is_main, default: false
      t.references :user, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
