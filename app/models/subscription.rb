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
class Subscription < ApplicationRecord
  belongs_to :brand
  belongs_to :user, required: true
  validates_numericality_of :frequency, greater_than: 0
  enum unit: { years: 'years', months: 'months', weeks: 'weeks', days: 'days' }

  # convert the frequency.unit into a Duration object. ex: '15 days' to 15 days
  def duration
    frequency.to_i.send(unit)
  end

  # ActiveSupport::Duration::PARTS
  # @param { String } period (days, weeks, months, or years)
  def amount_in(period = 'months')
    period = 'months' unless Subscription.units.include?(period)
    amount / duration.send("in_#{period}")
  end
end
