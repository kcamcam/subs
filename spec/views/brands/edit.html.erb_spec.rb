require 'rails_helper'

RSpec.describe 'brands/edit', type: :view do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
  end

  it 'renders the edit brand form' do
    render

    assert_select 'form[action=?][method=?]', brand_path(@brand), 'post' do
      assert_select 'input[name=?]', 'brand[image]'
      assert_select 'input[name=?]', 'brand[name]'
      assert_select 'input[name=?]', 'brand[info]'
      assert_select 'input[name=?]', 'brand[category]'
    end
  end
end
