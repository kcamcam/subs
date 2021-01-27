#
# Schema Info
#
# Table name: brands
#
# name        :string:index
# image       :text
# url         :string
# info        :string
# category    :string
# created_at  :datetime
# updated_at  :datetime
#
class Brand < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :subscriptions, dependent: :nullify
  validates :name, presence: true, uniqueness: true
  before_save :capitalize_name
  scope :search, ->(query) { where('lower(name) like ?', "%#{query.downcase}%") }

  private

  def capitalize_name
    self.name = name.downcase
  end
end
