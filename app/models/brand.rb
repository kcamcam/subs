class Brand < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :subscriptions
  validates :name, presence: true, uniqueness: true
end
