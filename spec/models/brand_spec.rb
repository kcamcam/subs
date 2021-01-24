require 'rails_helper'

RSpec.describe Brand, type: :model do
  before(:each) do
    @brand = create(:brand)
  end

  it 'is valid with valid attributes ' do
    expect(@brand).to be_valid
  end

  it 'is invalid with invalid attributes' do
    # name should be unique
    expect(build(:brand)).to_not be_valid
  end
end
