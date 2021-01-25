class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :subscriptions
end
