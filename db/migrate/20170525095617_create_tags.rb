class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :text, limit: 20

      t.timestamps
    end
    add_index :tags, :text, unique: true
  end
end
