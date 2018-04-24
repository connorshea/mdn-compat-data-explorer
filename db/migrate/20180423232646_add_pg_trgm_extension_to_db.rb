class AddPgTrgmExtensionToDb < ActiveRecord::Migration[5.2]
  def change
    execute "create extension pg_trgm;"
  end
end
