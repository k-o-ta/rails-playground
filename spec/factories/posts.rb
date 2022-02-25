FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:author) { |n| "author_#{n}" }
  end
end
