require 'rails_helper'

RSpec.describe '/brands', type: :request do
  before(:each) do
    @user = create(:user)
  end

  let(:valid_attributes) do
    {
      category: Faker::Company.type,
      custom: false,
      image: 'calendar.png',
      info: Faker::Company.buzzword,
      name: Faker::Company.name,
      url: Faker::Internet.url,
    }
  end

  let(:invalid_attributes) do
    {
      category: Faker::Company.type,
      custom: false,
      image: 'calendar.png',
      info: Faker::Company.buzzword,
      name: nil,
      released_at: Time.now,
      url: Faker::Internet.url,
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      brand1 = create(:brand, created_by: @user.id, released_by: @user.id)
      brand2 = create(:brand, created_by: @user.id, released_by: @user.id, id: 2)
      @brands = [brand1, brand2]

      get brands_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      brand = create(:brand, created_by: @user.id, released_by: @user.id)

      get brand_url(brand)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      get new_brand_url
      expect(response).to be_successful
    end

    it 'redirects un-authorized users' do
      get new_brand_url
      expect(response).to redirect_to '/login'
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      brand = create(:brand, created_by: @user.id)
      get edit_brand_url(brand)
      expect(response).to be_successful
    end

    it 'redirects un-authorized users' do
      brand = create(:brand, created_by: @user.id)
      get edit_brand_url(brand)
      expect(response).to redirect_to '/login'
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Brand' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        expect do
          post brands_url, params: { brand: valid_attributes }
        end.to change(Brand, :count).by(1)
      end

      it 'redirects to the created brand' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        post brands_url, params: { brand: valid_attributes }
        expect(response).to redirect_to(brand_url(Brand.last))
      end

      it 'redirects un-authorized users' do
        post brands_url, params: { brand: valid_attributes }
        expect(response).to redirect_to '/login'
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Brand' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        expect do
          post brands_url, params: { brand: invalid_attributes }
        end.to change(Brand, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        post brands_url, params: { brand: invalid_attributes }
        expect(response).to be_successful
      end

      it 'redirects un-authorized users' do
        post brands_url, params: { brand: invalid_attributes }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { image: 'calendar.png', name: 'NewName', category: 'NewCategory', info: 'NewInfo' }
      end

      it 'updates the requested brand' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        brand = create(:brand, created_by: @user.id)
        patch brand_url(brand), params: { brand: new_attributes }
        brand.reload
        expect(brand.name).to eq('NewName'.downcase)
        expect(brand.category).to eq('NewCategory')
        expect(brand.info).to eq('NewInfo')
      end

      it 'redirects to the brand' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        brand = create(:brand, created_by: @user.id)
        patch brand_url(brand), params: { brand: new_attributes }
        brand.reload
        expect(response).to redirect_to(brand_url(brand))
      end

      it 'redirects un-authorized users' do
        brand = create(:brand, created_by: @user.id)
        patch brand_url(brand), params: { brand: new_attributes }
        brand.reload
        expect(response).to redirect_to '/login'
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        brand = create(:brand, created_by: @user.id)
        patch brand_url(brand), params: { brand: invalid_attributes }
        expect(response).to be_successful
      end

      it 'redirects un-authorized users' do
        brand = create(:brand, created_by: @user.id)
        patch brand_url(brand), params: { brand: invalid_attributes }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested brand' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      brand = create(:brand, created_by: @user.id)
      expect do
        delete brand_url(brand)
      end.to change(Brand, :count).by(-1)
    end

    it 'redirects to the brands list' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Current).to receive(:user).and_return(@user)
      brand = create(:brand, created_by: @user.id)
      delete brand_url(brand)
      expect(response).to redirect_to(brands_url)
    end

    it 'redirects un-authorized users' do
      brand = create(:brand, created_by: @user.id)
      delete brand_url(brand)
      expect(response).to redirect_to '/login'
    end
  end
end
