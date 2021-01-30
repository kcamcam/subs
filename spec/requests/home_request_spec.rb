require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before(:each) do
    @user = create(:user)
  end

  describe "GET /index" do
    it "returns http success" do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "need not be logged in" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
