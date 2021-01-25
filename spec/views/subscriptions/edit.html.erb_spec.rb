require 'rails_helper'

RSpec.describe "subscriptions/edit", type: :view do
  before(:each) do
    @subscription = assign(:subscription, Subscription.create!(
      brand: nil,
      user: nil,
      amount: "9.99",
      frqufrequencyency: 1,
      unit: "MyString"
    ))
  end

  it "renders the edit subscription form" do
    render

    assert_select "form[action=?][method=?]", subscription_path(@subscription), "post" do
      assert_select "input[name=?]", "subscription[brand_id]"
      assert_select "input[name=?]", "subscription[user_id]"
      assert_select "input[name=?]", "subscription[amount]"
      assert_select "input[name=?]", "subscription[frequency]"
      assert_select "input[name=?]", "subscription[unit]"
    end
  end
end
