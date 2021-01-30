# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  amount     :decimal(, )
#  enabled    :boolean          default(TRUE), not null
#  first_bill :date
#  frequency  :integer
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint           indexed
#  user_id    :bigint           not null, indexed
#
# Indexes
#
#  index_subscriptions_on_brand_id  (brand_id)
#  index_subscriptions_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :subscription do
    id          { 1 }
    amount      { Faker::Number.decimal(l_digits: 2) }
    enabled     { true }
    first_bill  { Faker::Date.backward(days: 14) }
    frequency   { Faker::Number.non_zero_digit }
    unit        { 'days' }
  end
end
