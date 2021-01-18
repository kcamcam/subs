require 'rails_helper'

RSpec.describe "brands/show", type: :view do
  before(:each) do
    allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
    @brand = assign(:brand, Brand.create!(
      image: "calendar.png",
      name: "Name",
      info: "Info",
      category: "Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match("/#{asset_path('calendar.png')}/")
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Info/)
    expect(rendered).to match(/Category/)
  end
end
