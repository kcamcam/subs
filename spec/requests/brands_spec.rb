require 'rails_helper'

RSpec.describe '/brands', type: :request do
  let(:valid_attributes) do
    { image: 'calendar.png', name: 'Name', category: 'Category', info: 'Info' }
  end

  let(:invalid_attributes) do
    { image: 'calendar.png', name: nil, category: 'Category', info: 'Info' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
      brand1 = create(:brand)
      brand2 = create(:brand, id: 2, name: 'Name2')
      @brands = [brand1, brand2]

      get brands_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      allow_any_instance_of(Brand).to receive(:image_url).and_return 'calendar.png'
      brand = create(:brand)
      puts brand_url(brand)

      get brand_url(brand)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
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
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      brand = Brand.create! valid_attributes
      get edit_brand_url(brand)
      expect(response).to be_successful
    end

    it 'redirects un-authorized users' do
      brand = Brand.create! valid_attributes
      get edit_brand_url(brand)
      expect(response).to redirect_to '/login'
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Brand' do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
        expect do
          post brands_url, params: { brand: valid_attributes }
        end.to change(Brand, :count).by(1)
      end

      it 'redirects to the created brand' do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
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
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
        expect do
          post brands_url, params: { brand: invalid_attributes }
        end.to change(Brand, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
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
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
        brand = Brand.create! valid_attributes
        patch brand_url(brand), params: { brand: new_attributes }
        brand.reload
        expect(brand.name).to eq('NewName')
        expect(brand.category).to eq('NewCategory')
        expect(brand.info).to eq('NewInfo')
      end

      it 'redirects to the brand' do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
        brand = Brand.create! valid_attributes
        patch brand_url(brand), params: { brand: new_attributes }
        brand.reload
        expect(response).to redirect_to(brand_url(brand))
      end

      it 'redirects un-authorized users' do
        brand = Brand.create! valid_attributes
        patch brand_url(brand), params: { brand: new_attributes }
        brand.reload
        expect(response).to redirect_to '/login'
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
        brand = Brand.create! valid_attributes
        patch brand_url(brand), params: { brand: invalid_attributes }
        expect(response).to be_successful
      end

      it 'redirects un-authorized users' do
        brand = Brand.create! valid_attributes
        patch brand_url(brand), params: { brand: invalid_attributes }
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested brand' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      brand = Brand.create! valid_attributes
      expect do
        delete brand_url(brand)
      end.to change(Brand, :count).by(-1)
    end

    it 'redirects to the brands list' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      brand = Brand.create! valid_attributes
      delete brand_url(brand)
      expect(response).to redirect_to(brands_url)
    end

    it 'redirects un-authorized users' do
      brand = Brand.create! valid_attributes
      delete brand_url(brand)
      expect(response).to redirect_to '/login'
    end
  end
end
