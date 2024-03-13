FactoryBot.define do
  factory :order_address do
    token {"tok_abcdefghijk00000000000000000"}
    zip_code { "123-4567" }
    city_id { Faker::Number.between(from: 2, to: City.count) }
    town { Gimei.address.city }
    house_number { Gimei.address.town }
    building_name { Faker::Company.name }
    phone_number { Faker::Number.number(digits: 11) }

  end
end

