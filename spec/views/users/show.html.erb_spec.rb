require 'rails_helper'

RSpec.describe "users/profile", type: :view do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
    allow_any_instance_of(Auth0Helper).to receive(:current_user).and_return current_user
    @current_user = current_user
  end

  def current_user
    {
      uid: 'apple|1234567890',
      info: {
        nickname: 'nickname',
        image: 'https://lh3.googleusercontent.com/a-/AOh14Gi7D7aOob6eoG1tWFY4JuUdmu3cj84RfqBkdCJ7TFI=s96-c',
        name: 'FirstName LastName',
        email: 'email@email.com'
      },
      raw_info: {
        sub: 'apple|1234567890',
        given_name: 'FirstName',
        family_name: 'LastName',
        nickname: 'nickname',
        name: 'FirstName LastName',
        picture: 'https://lh3.googleusercontent.com/a-/AOh14Gi7D7aOob6eoG1tWFY4JuUdmu3cj84RfqBkdCJ7TFI=s96-c',
        locale: 'en',
        updated_at: '2021-01-24T03:15:56.686Z',
        email: 'email@email.com',
        email_verified: true
      }
    }
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/nickname/)
  end
end
