class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.text :description
      t.string :image
      t.references :album, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
