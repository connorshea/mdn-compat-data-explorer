class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :name
      t.string :description
      t.string :mdn_url
      t.boolean :deprecated
      t.boolean :experimental
      t.boolean :standard_track
      t.jsonb :support

      t.timestamps
    end
  end
end
