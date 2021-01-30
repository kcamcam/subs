require 'rails_helper'

RSpec.describe 'subscriptions/new', type: :view do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
    @subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)
    allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
  end

  it 'renders new subscription form' do
    puts render

    assert_select 'form[action=?][method=?]', subscription_path(@subscription), 'post' do
      assert_select 'input[name=?]', 'subscription[brand_id]'
      assert_select 'input[name=?]', 'subscription[amount]'
      assert_select 'input[name=?]', 'subscription[frequency]'
      assert_select 'select[name=?]', 'subscription[unit]'
    end
  end
end
