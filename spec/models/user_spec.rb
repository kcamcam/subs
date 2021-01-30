require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  it 'is valid with valid attributes ' do
    expect(@user).to be_valid
  end

  it 'ensures UID is unique' do
    expect(build(:user, id: 2, uid: @user.uid)).to_not be_valid
  end
end
