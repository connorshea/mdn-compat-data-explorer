class AddSlugToFeatures < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :slug, :string, null: false
    add_index :features, :slug, unique: true
  end
end
