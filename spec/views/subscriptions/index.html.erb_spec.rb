require 'rails_helper'

RSpec.describe "subscriptions/index", type: :view do
  before(:each) do
    assign(:subscriptions, [
      Subscription.create!(
        brand: nil,
        user: nil,
        amount: "9.99",
        frequency: 2,
        unit: "Unit"
      ),
      Subscription.create!(
        brand: nil,
        user: nil,
        amount: "9.99",
        frequency: 2,
        unit: "Unit"
      )
    ])
  end

  it "renders a list of subscriptions" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Unit".to_s, count: 2
  end
end
