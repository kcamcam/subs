require 'rails_helper'

RSpec.describe Subscription, type: :model do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id, released_by: @user.id)
    @subscription = create(:subscription, brand_id: @brand.id, user_id: @user.id)
  end

  it 'is valid with valid attributes ' do
    expect(@subscription).to be_valid
  end

  it 'ensures user_id is present' do
    @subscription.user_id = nil
    expect(@subscription).to_not be_valid
  end
end
