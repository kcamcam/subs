require 'rails_helper'

RSpec.describe 'brands/index', type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
    @user = create(:user)

    @brand1 = create(:brand, created_by: @user.id)
    @brand2 = create(:brand, id: 2, name: Faker::Company.name, created_by: @user.id)
    @brands = [@brand1, @brand2]
  end

  it 'renders a list of brands' do
    render
    assert_select 'tr>td>a>img', count: 2
    assert_select 'tr>td', text: @brand1.brand_name, count: 1
    assert_select 'tr>td', text: @brand2.brand_name, count: 1
    assert_select 'tr>td>a', text: 'Create Subscription', count: 2
  end
end
