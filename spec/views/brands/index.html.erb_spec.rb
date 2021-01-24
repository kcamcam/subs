require 'rails_helper'

RSpec.describe 'brands/index', type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
    @brand1 = create(:brand)
    @brand2 = create(:brand, id: 2, name: 'Name2')
    @brands = [@brand1, @brand2]
  end

  it 'renders a list of brands' do
    render
    assert_select 'tr>td>img', count: 2
    assert_select 'tr>td', text: @brand1.name, count: 1
    assert_select 'tr>td', text: @brand2.name, count: 1
    assert_select 'tr>td', text: @brand1.info, count: 2
    assert_select 'tr>td', text: @brand1.category, count: 2
  end
end
