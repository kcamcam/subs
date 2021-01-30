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
FactoryBot.define do
  factory :user do
    id          { 1 }
    admin       { false }
    email       { Faker::Internet.email }
    enabled     { true }
    family_name { Faker::Name.last_name }
    given_name  { Faker::Name.first_name }
    image       { 'calendar.png' }
    locale      { 'en' }
    name        { Faker::Internet.username }
    nickname    { Faker::Name.name }
    uid         { "google|#{Faker::Omniauth.google[:uid]}" }
  end
end
