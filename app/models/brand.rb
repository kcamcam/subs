class Brand < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :subscriptions, dependent: :nullify
  validates :name, presence: true, uniqueness: true
  before_save :capitalize_name

  private

  def capitalize_name
    self.name = name.upcase
  end
end
