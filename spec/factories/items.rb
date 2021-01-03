FactoryBot.define do
  factory :item do
    name            { Faker::Books::Dune.title }
    text            { Faker::Lorem.sentence }
    category_id     { Faker::Number.within(range: 2..11) }
    state_id        { Faker::Number.within(range: 2..7) }
    delivery_fee_id { Faker::Number.within(range: 2..3) }
    prefecture_id   { Faker::Number.within(range: 2..48) }
    days_to_ship_id { Faker::Number.within(range: 2..4) }
    price           { Faker::Number.number(digits: 7) }
    association :user
    after(:build) do |item|
      item.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_imag.png')
    end
  end
end
