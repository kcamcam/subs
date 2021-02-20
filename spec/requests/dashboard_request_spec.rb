require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
    create(:subscription, user_id: @user.id, brand_id: @brand.id)
    allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
    allow_any_instance_of(Current).to receive(:user).and_return(@user)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/dashboard/index'
      expect(response).to have_http_status(:success)
    end
  end
end
