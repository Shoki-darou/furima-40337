FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    first_name_kana { Faker::Japanese::Name.first_name }
    last_name_kana { Faker::Japanese::Name.last_name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end