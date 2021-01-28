# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  uid        :string           not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_uid  (uid) UNIQUE
#
class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :subscriptions
end
