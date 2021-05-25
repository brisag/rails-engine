FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 20) }
    unit_price { Faker::Number.between(from: 1, to: 1000) }
    item
    invoice
  end
end
