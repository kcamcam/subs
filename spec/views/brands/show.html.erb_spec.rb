require 'rails_helper'

RSpec.describe 'brands/show', type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to match(/#{File.basename(@brand.image_url, '.png')}/)
    expect(rendered).to match(/#{@brand.brand_name}/)
    expect(rendered).to match(/#{@brand.info}/)
    expect(rendered).to match(/#{@brand.category}/)
  end
end
