# == Schema Information
#
# Table name: brands
#
#  id          :bigint           not null, primary key
#  category    :string
#  created_by  :integer          not null, indexed
#  custom      :boolean          default(FALSE), indexed
#  image       :text
#  info        :string
#  name        :string           indexed
#  released_at :datetime
#  released_by :integer
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_brands_on_created_by  (created_by)
#  index_brands_on_custom      (custom)
#  index_brands_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (created_by => users.id)
#  fk_rails_...  (released_by => users.id)
#

# The image attribute has 3 different sizes:
# image_url(:thumb)   : 64x64
# image_url(:preview) : 128x128
# image_url           : 256x256
class Brand < ApplicationRecord
  mount_uploader :image, ImageUploader
  # RELATIONS
  has_many :subscriptions, dependent: :nullify
  belongs_to :user,     class_name: 'User', foreign_key: :created_by, required: true, optional: false
  belongs_to :releaser, class_name: 'User', foreign_key: :released_by, required: false, optional: true
  # VALIDATIONS
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
