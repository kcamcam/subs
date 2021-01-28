# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  amount     :decimal(, )
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
class Subscription < ApplicationRecord
  belongs_to :brand
  belongs_to :user
  # see ActiveSupport::Duration::PARTS
  # eval('frequency.unit') to convert '7.days' to 7.days
  enum unit: { years: 'years', months: 'months', weeks: 'weeks', days: 'days',
               hours: 'hours', minutes: 'minutes', seconds: 'seconds'}
end
