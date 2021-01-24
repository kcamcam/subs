require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  it 'is valid with valid attributes ' do
    expect(@user).to be_valid
  end

  it 'is invalid with invalid attributes' do
    # name should be unique
    expect(build(:user)).to_not be_valid
  end
end
