#
# Schema Info
#
# Table name: subscriptions
#
# brand_id       :bigint:index
# user_id        :bigint:index
# amount         :decimal
# frequency      :integer
# unit           :string
# created_at     :datetime
# updated_at     :datetime
#
class Subscription < ApplicationRecord
  belongs_to :brand
  belongs_to :user
  # see ActiveSupport::Duration::PARTS
  # eval('frequency.unit') to convert '7.days' to 7.days
  enum unit: { years: 'years', months: 'months', weeks: 'weeks', days: 'days',
               hours: 'hours', minutes: 'minutes', seconds: 'seconds'}
end
