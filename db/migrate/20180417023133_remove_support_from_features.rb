class RemoveSupportFromFeatures < ActiveRecord::Migration[5.2]
  def change
    remove_column :features, :support, :jsonb
  end
end
