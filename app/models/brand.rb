class Brand < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true
end
