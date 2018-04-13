class CreateBrowsers < ActiveRecord::Migration[5.2]
  def change
    create_table :browsers do |t|
      t.string :id
      t.string :name

      t.timestamps
    end
  end
end
