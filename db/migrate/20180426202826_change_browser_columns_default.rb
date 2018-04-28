class ChangeBrowserColumnsDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :features, :chrome, from: '{}', to: nil
    change_column_default :features, :chrome_android, from: '{}', to: nil
    change_column_default :features, :edge, from: '{}', to: nil
    change_column_default :features, :edge_mobile, from: '{}', to: nil
    change_column_default :features, :firefox, from: '{}', to: nil
    change_column_default :features, :firefox_android, from: '{}', to: nil
    change_column_default :features, :ie, from: '{}', to: nil
    change_column_default :features, :nodejs, from: '{}', to: nil
    change_column_default :features, :opera, from: '{}', to: nil
    change_column_default :features, :qq_android, from: '{}', to: nil
    change_column_default :features, :safari, from: '{}', to: nil
    change_column_default :features, :safari_ios, from: '{}', to: nil
    change_column_default :features, :samsunginternet_android, from: '{}', to: nil
    change_column_default :features, :uc_android, from: '{}', to: nil
    change_column_default :features, :uc_chinese_android, from: '{}', to: nil
    change_column_default :features, :webview_android, from: '{}', to: nil
  end
end
