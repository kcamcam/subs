FactoryBot.define do
  factory :subscription do
    id { 1 }
    brand
    user
    amount { '9.99' }
    frequency { 7 }
    unit { 'days' }
  end
end
