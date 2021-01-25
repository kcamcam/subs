require 'rails_helper'

RSpec.describe '/subscriptions', type: :request do
  let(:valid_attributes) do
    { amount: '9.99', frequency: '7', unit: 'days' }
  end

  let(:invalid_attributes) do
    { amount: '9.99', frequency: '7', unit: 'days' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Subscription.create! valid_attributes
      get subscriptions_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      subscription = Subscription.create! valid_attributes
      get subscription_url(subscription)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
      get new_subscription_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      subscription = Subscription.create! valid_attributes
      get edit_subscription_url(subscription)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Subscription' do
        expect do
          post subscriptions_url, params: { subscription: valid_attributes }
        end.to change(Subscription, :count).by(1)
      end

      it 'redirects to the created subscription' do
        post subscriptions_url, params: { subscription: valid_attributes }
        expect(response).to redirect_to(subscription_url(Subscription.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Subscription' do
        expect do
          post subscriptions_url, params: { subscription: invalid_attributes }
        end.to change(Subscription, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post subscriptions_url, params: { subscription: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested subscription' do
        subscription = Subscription.create! valid_attributes
        patch subscription_url(subscription), params: { subscription: new_attributes }
        subscription.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the subscription' do
        subscription = Subscription.create! valid_attributes
        patch subscription_url(subscription), params: { subscription: new_attributes }
        subscription.reload
        expect(response).to redirect_to(subscription_url(subscription))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        subscription = Subscription.create! valid_attributes
        patch subscription_url(subscription), params: { subscription: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested subscription' do
      subscription = Subscription.create! valid_attributes
      expect do
        delete subscription_url(subscription)
      end.to change(Subscription, :count).by(-1)
    end

    it 'redirects to the subscriptions list' do
      subscription = Subscription.create! valid_attributes
      delete subscription_url(subscription)
      expect(response).to redirect_to(subscriptions_url)
    end
  end
end
