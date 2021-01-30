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
FactoryBot.define do
  factory :brand do
    id          { 1 }
    category    { Faker::Company.type }
    custom      { false }
    image       { 'calendar.png' }
    info        { Faker::Company.buzzword }
    name        { Faker::Company.name }
    released_at { Time.now }
    url         { Faker::Internet.url }
  end
end
