FactoryBot.define do
  factory :item do
    item_name       { Faker::Commerce.product_name }
    content         { Faker::Lorem.paragraph }
    category_id     { Faker::Number.between(from: 2, to: Category.count) }
    delivery_id     { Faker::Number.between(from: 2, to: Delivery.count) }
    city_id         { Faker::Number.between(from: 2, to: City.count) }
    days_to_ship_id { Faker::Number.between(from: 2, to: DaysToShip.count) }
    status_id       { Faker::Number.between(from: 2, to: Status.count) }
    price           { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public', 'images', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end