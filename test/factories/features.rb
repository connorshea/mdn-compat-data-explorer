# == Schema Information
#
# Table name: features
#
#  id                      :bigint(8)        not null, primary key
#  chrome                  :jsonb
#  chrome_android          :jsonb
#  deprecated              :boolean
#  description             :string
#  edge                    :jsonb
#  edge_mobile             :jsonb
#  experimental            :boolean
#  firefox                 :jsonb
#  firefox_android         :jsonb
#  ie                      :jsonb
#  mdn_url                 :string
#  name                    :string
#  nodejs                  :jsonb
#  opera                   :jsonb
#  qq_android              :jsonb
#  safari                  :jsonb
#  safari_ios              :jsonb
#  samsunginternet_android :jsonb
#  standard_track          :boolean
#  uc_android              :jsonb
#  uc_chinese_android      :jsonb
#  webview_android         :jsonb
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryBot.define do
  factory :feature, class: Feature do
    sequence(:name) { |n| "feature#{n}" }

    factory :has_description do
      description "Lorem ipsum"
    end

    factory :has_mdn_url do
      mdn_url "https://developer.mozilla.org/docs/Web/HTML/Element/header"
    end

    factory :deprecated_true do
      deprecated true
    end

    factory :deprecated_false do
      deprecated false
    end

    factory :experimental_true do
      experimental true
    end

    factory :experimental_false do
      experimental false
    end

    factory :standard_track_true do
      standard_track true
    end

    factory :standard_track_false do
      standard_track false
    end

    factory :firefox_true_simple_one do
      firefox { { version_added: true } }
    end

    factory :firefox_true_simple_two do
      firefox { { version_added: "1" } }
    end

    factory :firefox_true_complex_one do
      firefox {
        {
          version_added: true,
          alternative_name: "feature_with_firefox_alternative_name"
        }
      }
    end

    factory :firefox_true_complex_two do
      firefox {
        [
          {
            version_added: "63"
          },
          {
            version_added: "60",
            version_removed: "61"
          }
        ]
      }
    end

    factory :firefox_false do
      firefox { { version_added: false } }
    end
  end
end
