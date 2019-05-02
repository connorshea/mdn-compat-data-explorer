# frozen_string_literal: true

class AddOperaAndroidToBrowsers < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :opera_android, :jsonb, default: nil
  end
end
