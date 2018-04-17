class AddBrowserColumnsToFeatures < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :chrome, :jsonb, default: '{}'
    add_column :features, :chrome_android, :jsonb, default: '{}'
    add_column :features, :edge, :jsonb, default: '{}'
    add_column :features, :edge_mobile, :jsonb, default: '{}'
    add_column :features, :firefox, :jsonb, default: '{}'
    add_column :features, :firefox_android, :jsonb, default: '{}'
    add_column :features, :ie, :jsonb, default: '{}'
    add_column :features, :nodejs, :jsonb, default: '{}'
    add_column :features, :opera, :jsonb, default: '{}'
    add_column :features, :qq_android, :jsonb, default: '{}'
    add_column :features, :safari, :jsonb, default: '{}'
    add_column :features, :safari_ios, :jsonb, default: '{}'
    add_column :features, :samsunginternet_android, :jsonb, default: '{}'
    add_column :features, :uc_android, :jsonb, default: '{}'
    add_column :features, :uc_chinese_android, :jsonb, default: '{}'
    add_column :features, :webview_android, :jsonb, default: '{}'
  end
end
