require 'rails_helper'

RSpec.describe "subscriptions/new", type: :view do
  before(:each) do
    assign(:subscription, Subscription.new(
      brand: nil,
      user: nil,
      amount: "9.99",
      frequency: 1,
      unit: "MyString"
    ))
  end

  it "renders new subscription form" do
    render

    assert_select "form[action=?][method=?]", subscriptions_path, "post" do

      assert_select "input[name=?]", "subscription[brand_id]"

      assert_select "input[name=?]", "subscription[user_id]"

      assert_select "input[name=?]", "subscription[amount]"

      assert_select "input[name=?]", "subscription[frequency]"

      assert_select "input[name=?]", "subscription[unit]"
    end
  end
end
