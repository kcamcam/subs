require 'rails_helper'

RSpec.describe '/users', type: :request do
  before(:each) do
    @user = create(:user)
  end

  let(:valid_attributes) do
    { uid: 'apple|1234567890' }
  end

  let(:invalid_attributes) do
    { uid: nil }
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      get profile_url
      expect(response).to be_successful
    end

    it 'redirects un-authorized user' do
      get profile_url
      expect(response).to redirect_to '/login'
    end
  end
end
