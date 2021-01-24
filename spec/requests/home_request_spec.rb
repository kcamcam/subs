require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      get "/"
      expect(response).to have_http_status(:success)
    end

    it 'redirects un-authorized user' do
      get "/"
      expect(response).to redirect_to '/login'
    end
  end
end
