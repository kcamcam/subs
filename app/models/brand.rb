# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  category   :string
#  image      :text
#  info       :string
#  name       :string           indexed
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#

# The image attribute stores 3 different sizes:
# image_url(:thumb)   : 64x64
# image_url(:preview) : 128x128
# image_url           : 256x256
class Brand < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :subscriptions, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  before_save :downcase_name
  scope :search, ->(query) { where('lower(name) like ?', "%#{query.downcase}%") }

  def brand_name
    name.capitalize
  end

  private

  def downcase_name
    self.name = name.downcase
  end
end
