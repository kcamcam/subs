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

  it 'ensures frequency is positive' do
    @subscription.frequency = 0
    expect(@subscription).to_not be_valid
  end

  it 'ensures unit gets singularized' do
    @subscription.update(frequency: 1, unit: 'days')
    expect(units(@subscription)).to eq('day')
  end

  it 'ensures the frequency & unit get concatenated' do
    @subscription.update(frequency: 1, unit: 'days')
    expect(@subscription.freq).to eq('1 day')
  end
end
