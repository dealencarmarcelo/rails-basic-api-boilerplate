FactoryBot.define do
  factory :user do
    password = Faker::Alphanumeric.alphanumeric(number: 10)

    name { Faker::Name.full_name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end