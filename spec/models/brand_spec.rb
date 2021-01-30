require 'rails_helper'

RSpec.describe Brand, type: :model do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id, released_by: @user.id)
  end

  it 'is valid with valid attributes ' do
    expect(@brand).to be_valid
  end

  it 'ensures name is unique' do
    expect(build(:brand, name: @brand.name, id: 2)).to_not be_valid
  end

  it 'ensures created_by is present' do
    @brand.created_by = nil
    expect(@brand).to_not be_valid
  end
end
