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
