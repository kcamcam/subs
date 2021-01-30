require 'rails_helper'

RSpec.describe "users/profile", type: :view do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(Current).to receive(:user).and_return(@user)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/#{@user.nickname}/)
  end
end
