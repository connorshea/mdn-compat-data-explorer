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

    trait :has_description do
      description "Lorem ipsum"
    end

    trait :has_mdn_url do
      mdn_url "https://developer.mozilla.org/docs/Web/HTML/Element/header"
    end

    trait :deprecated_true do
      deprecated true
    end

    trait :deprecated_false do
      deprecated false
    end

    trait :experimental_true do
      experimental true
    end

    trait :experimental_false do
      experimental false
    end

    trait :standard_track_true do
      standard_track true
    end

    trait :standard_track_false do
      standard_track false
    end

    trait :firefox_true_simple_one do
      firefox { { version_added: true } }
    end

    trait :firefox_true_simple_two do
      firefox { { version_added: "1" } }
    end

    trait :firefox_true_complex_one do
      firefox {
        {
          version_added: true,
          alternative_name: "feature_with_firefox_alternative_name"
        }
      }
    end

    trait :firefox_true_complex_two do
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

    factory :feature_with_description, traits: [:has_description]
    factory :feature_with_mdn_url, traits: [:has_mdn_url]
    
    factory :feature_deprecated, traits: [:deprecated_true]
    factory :feature_not_deprecated, traits: [:deprecated_false]

    factory :feature_standard_track, traits: [:standard_track_true]
    factory :feature_not_standard_track, traits: [:standard_track_false]

    factory :feature_experimental, traits: [:experimental_true]
    factory :feature_not_experimental, traits: [:experimental_false]

    factory :feature_firefox_true_simple_one, traits: [:firefox_true_simple_one]
    factory :feature_firefox_true_simple_two, traits: [:firefox_true_simple_two]
    factory :feature_firefox_true_complex_one, traits: [:firefox_true_complex_one]
    factory :feature_firefox_true_complex_two, traits: [:firefox_true_complex_two]
  end
end
