class AddReleasesToBrowsers < ActiveRecord::Migration[5.2]
  def change
    add_column :browsers, :releases, :jsonb, default: '{}'
  end
end
