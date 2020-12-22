FactoryBot.define do
  factory :order_ship do
    postal_code    { '123-4567' }
    prefecture_id  { 2 }
    municipalities { 'テスト市' }
    address        { '1-1' }
    building_name  { 'テストハイツ' }
    tel            { '1234567890' }
    token          { 'tok_abcdefghijk00000000000000000' }
  end
end
