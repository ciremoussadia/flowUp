# frozen_string_literal: true

require 'rails_helper'

describe 'create subscription', type: :request do
  context 'with valid data' do
    it 'saves to db and redirect to home' do
      expect  do
        post '/subscriptions', params: { subscription: attributes_for(:subscription) }
      end.to change(Subscription, :count)

      expect(response).to redirect_to root_path
      expect(flash[:success]).to be_present
    end
  end

  context 'with invalid data' do
    it 'do not save to db and reload form' do
      expect do
        post '/subscriptions', params: { subscription: attributes_for(:subscription, name: '') }
      end.to_not change(Subscription, :count)
    end
    it 'reload form' do
      post '/subscriptions', params: { subscription: attributes_for(:subscription, name: '') }
      expect(response.code).to eq('200')
    end
  end
end
