class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
end
