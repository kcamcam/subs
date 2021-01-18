require 'rails_helper'

RSpec.describe 'brands/index', type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
    assign(:brands, [
             Brand.create!(
               image: 'calendar.png',
               name: 'Name1',
               info: 'Info',
               category: 'Category'
             ),
             Brand.create!(
               image: 'calendar.png',
               name: 'Name2',
               info: 'Info',
               category: 'Category'
             )
           ])
  end

  it 'renders a list of brands' do
    render
    # assert_select "tr>td", text: "calendar.png".to_s, count: 2
    assert_select 'tr>td', text: 'Name1'.to_s, count: 1
    assert_select 'tr>td', text: 'Name1'.to_s, count: 1
    assert_select 'tr>td', text: 'Info'.to_s, count: 2
    assert_select 'tr>td', text: 'Category'.to_s, count: 2
  end
end
