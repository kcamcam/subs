# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  admin       :boolean          default(FALSE)
#  email       :string
#  enabled     :boolean          default(TRUE)
#  family_name :string
#  given_name  :string
#  image       :text
#  locale      :string
#  name        :string
#  nickname    :string
#  uid         :string           not null, indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_uid  (uid)
#
class User < ApplicationRecord
  # RELATIONS
  has_many :subscriptions
  has_many :brands,   class_name: 'Brand', foreign_key: :crated_by
  has_many :releases, class_name: 'Brand', foreign_key: :released_by
  # VALIDATIONS
  validates :uid, presence: true, uniqueness: true
end
