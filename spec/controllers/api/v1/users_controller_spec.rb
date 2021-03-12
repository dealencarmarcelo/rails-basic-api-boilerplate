require 'rails_helper'

describe Api::V1::UsersController, type: :controller do 
  before do
    @user = FactoryBot.create(:user)

    password = Faker::Alphanumeric.alphanumeric(number: 8)
    @params = {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password
    }
  end

  describe '#index' do
    it 'succeeds' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'succeeds' do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status(:success)
    end
    it 'return not_found on an invalid id' do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
      expect(json_errors['code']).to eq('not_found')
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'succeeds' do
        post :create, params: @params
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity' do
        @params[:name] = nil
        post :create, params: @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'succeeds' do
        @params[:name] = Faker::Name.name
        put :update, params: { id: @user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'returns not_found with invalid user' do
        put :update, params: { id: 0, name: Faker::Name.name }
        expect(response).to have_http_status(:not_found)
      end
      it 'returns unprocessable entity with nil name' do
        @params[:name] = nil
        @params[:id] = @user.id
        put :update, params: @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'returns unprocessable entity with nil email' do
        @params[:email] = nil
        @params[:id] = @user.id
        put :update, params: @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    context 'with valid params' do
      it 'succeeds' do
        post :destroy, params: { id: @user.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid params' do
      it 'returns not_found' do
        post :destroy, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end