require 'rails_helper'

RSpec.describe 'subscriptions/show', type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
    @subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/#{File.basename(@brand.image_url, '.png')}/)
    expect(rendered).to match(/#{@subscription.amount}/)
    expect(rendered).to match(/#{@subscription.frequency}/)
    expect(rendered).to match(/#{@subscription.unit}/)
  end
end
