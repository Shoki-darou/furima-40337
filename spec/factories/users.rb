FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    name { Faker::Name.name }
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
  
end