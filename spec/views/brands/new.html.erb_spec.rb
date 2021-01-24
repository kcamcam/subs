require 'rails_helper'

RSpec.describe 'brands/new', type: :view do
  before(:each) do
    @brand = build_stubbed(:brand)
  end

  it 'renders new brand form' do
    render

    assert_select 'form[action=?][method=?]', brand_path(@brand), 'post' do
      assert_select 'input[name=?]', 'brand[image]'
      assert_select 'input[name=?]', 'brand[name]'
      assert_select 'input[name=?]', 'brand[info]'
      assert_select 'input[name=?]', 'brand[category]'
    end
  end
end
