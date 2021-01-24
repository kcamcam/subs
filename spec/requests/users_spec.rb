require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:valid_attributes) do
    { uid: 'apple|1234567890' }
  end

  let(:invalid_attributes) do
    { uid: nil }
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

  describe 'GET /show' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      allow_any_instance_of(Auth0Helper).to receive(:current_user).and_return current_user
      @current_user = current_user
      User.create! valid_attributes
      get profile_url
      expect(response).to be_successful
    end

    it 'redirects un-authorized user' do
      user = User.create! valid_attributes
      get profile_url
      expect(response).to redirect_to '/login'
    end
  end
end
