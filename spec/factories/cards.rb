FactoryBot.define do
  factory :card do
    card_token     { 'tok_abcdefghijk00000000000000000' }
    customer_token { 'tok_abcdefghijk00000000000000000' }
    user_id        { 1 }
    association :user
  end
end
