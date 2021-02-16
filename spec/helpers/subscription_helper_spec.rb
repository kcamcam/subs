require "rails_helper"

RSpec.describe SubscriptionHelper, :type => :helper do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id, released_by: @user.id)
    @subscription = create(:subscription, brand_id: @brand.id, user_id: @user.id)
  end

  describe 'unit' do
    it 'ensures unit gets singularized' do
      @subscription.update(frequency: 1, unit: 'days')
      expect(units(@subscription)).to eq('day')
    end

    it 'ensures unit does not get singularized' do
      @subscription.update(frequency: 2, unit: 'days')
      expect(units(@subscription)).to eq('days')
    end
  end

  describe 'frequency' do
    it 'ensures the frequency & unit get concatenated' do
      @subscription.update(frequency: 1, unit: 'days')
      expect(freq(@subscription)).to eq('1 day')
    end
  end
end
