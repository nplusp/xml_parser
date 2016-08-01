# == Schema Information
#
# Table name: material_sources
#
#  id            :integer          not null, primary key
#  url           :string           not null
#  supplier_name :string
#  title         :string
#  episode       :string
#  year          :string
#  duration      :string
#  aspect_ratio  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :material_source do
    trait :with_invalid_url do
      url { 'fb.com/material.xml' }
    end

    trait :with_unparseable_url do
      url { 'http://fb.com/material.xml' }
    end

    factory :valid_material_source do
      url { ENV[XML_1] }
    end

    factory :invalid_url_material_source, traits: [:with_invalid_url]
    factory :unparseable_url_material_source, traits: [:with_unparseable_url]
  end
end
