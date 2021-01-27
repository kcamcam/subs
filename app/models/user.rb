#
# Schema Info
#
# Table name:  users
#
# uid         :string:index
# created_at  :datetime
# updated_at  :datetime
#

class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :subscriptions
end
