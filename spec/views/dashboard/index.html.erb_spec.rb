require 'rails_helper'

RSpec.describe "dashboard/index.html.erb", type: :view do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
    @subscription1 = create(:subscription, user_id: @user.id, brand_id: @brand.id)
    @subscription2 = create(:subscription, user_id: @user.id, brand_id: @brand.id, id: 2)
    @subscriptions = Subscription.where(id: [@subscription1, @subscription2])
  end

  it 'renders a subscription dashboard' do
    render
  end
end
