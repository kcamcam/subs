require 'rails_helper'

RSpec.describe '/subscriptions', type: :request do
  before(:each) do
    @user = create(:user)
    @brand = create(:brand, created_by: @user.id)
  end

  let(:valid_attributes) do
    {
      amount: Faker::Number.decimal(l_digits: 2),
      first_bill: Faker::Date.backward(days: 14),
      frequency: Faker::Number.non_zero_digit,
      unit: 'days',
    }
  end

  let(:invalid_attributes) do
    {
      amount: Faker::Number.decimal(l_digits: 2),
      enabled: false,
      first_bill: Faker::Date.backward(days: 14),
      frequency: 0,
      unit: 'days',
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      subscription1 = create(:subscription, user_id: @user.id, brand_id: @brand.id)
      subscription2 = create(:subscription, user_id: @user.id, brand_id: @brand.id, id: 2)
      @subscriptions = [subscription1, subscription2]

      get subscriptions_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)
      get subscription_url(subscription)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      get new_subscription_url(brand_id: @brand.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)
      get edit_subscription_url(subscription)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Subscription' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        expect do
          valid_attributes[:brand_id] = @brand.id
          post subscriptions_url, params: { subscription: valid_attributes }
        end.to change(Subscription, :count).by(1)
      end

      it 'redirects to the created subscription' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        valid_attributes[:brand_id] = @brand.id
        post subscriptions_url, params: { subscription: valid_attributes }
        expect(response).to redirect_to(subscription_url(Subscription.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Subscription' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
        expect do
          invalid_attributes[:brand_id] = @brand.id
          post subscriptions_url, params: { subscription: invalid_attributes }
        end.to change(Subscription, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Current).to receive(:user).and_return(@user)
        allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
        invalid_attributes[:brand_id] = @brand.id
        post subscriptions_url, params: { subscription: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          amount: 30.00,
          first_bill: Date.today - 14.days,
          frequency: 3,
          unit: 'months',
        }
      end

      it 'updates the requested subscription' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)

        patch subscription_url(subscription), params: { subscription: new_attributes }
        subscription.reload

        expect(subscription.amount).to eq(new_attributes[:amount])
        expect(subscription.first_bill).to eq(new_attributes[:first_bill])
        expect(subscription.frequency).to eq(new_attributes[:frequency])
        expect(subscription.unit).to eq('months')
      end

      it 'redirects to the subscription' do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)

        patch subscription_url(subscription), params: { subscription: new_attributes }
        subscription.reload

        expect(response).to redirect_to(subscription_url(subscription))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
        allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
        subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)

        patch subscription_url(subscription), params: { subscription: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested subscription' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)

      expect do
        delete subscription_url(subscription)
      end.to change(Subscription, :count).by(-1)
    end

    it 'redirects to the subscriptions list' do
      allow_any_instance_of(ApplicationController).to receive(:set_current_user).and_return(@user)
      allow_any_instance_of(Brand).to receive(:image_url).and_return('calendar.png')
      subscription = create(:subscription, user_id: @user.id, brand_id: @brand.id)

      delete subscription_url(subscription)
      expect(response).to redirect_to(subscriptions_url)
    end
  end
end
