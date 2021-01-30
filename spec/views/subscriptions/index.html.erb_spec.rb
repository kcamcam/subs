require 'rails_helper'

RSpec.describe 'subscriptions/index', type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
    @subscription1 = create(:subscription, user_id: @user.id, brand_id: @brand.id)
    @subscription2 = create(:subscription, user_id: @user.id, brand_id: @brand.id, id: 2)
    @subscriptions = [@subscription1, @subscription2]
  end

  it 'renders a list of subscriptions' do
    puts render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: @subscription1.amount.to_s, count: 1
    assert_select 'tr>td', text: @subscription2.amount.to_s, count: 1
  end
end
