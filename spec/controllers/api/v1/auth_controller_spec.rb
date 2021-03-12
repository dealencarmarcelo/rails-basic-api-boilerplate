require 'rails_helper'

describe Api::V1::AuthController, type: :controller do 
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

  describe '#signin' do
    context 'with valid params' do
      it 'returns success' do
        post :signin, params: { email: @user.email, password: @user.password }
        expect(response).to have_http_status(:success)
      end
    end
    context 'with invalid params' do
      it 'returns unprocessable_entity on an invalid email' do
        post :signin, params: { email: Faker::Internet.email, password: @user.password }
        expect(response).to have_http_status(:unauthorized)
      end
      it 'returns unprocessable_entity on an invalid password' do
        post :signin, params: { email: @user.email, password: Faker::Internet.password }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#signup' do
    context 'with valid params'do
      it 'returns success' do
        post :signup, params: @params
        expect(response).to have_http_status(:success)
      end
    end
    context 'with invalid params' do
      it 'returns unprocessable entity with invalid name' do
        @params[:name] = nil
        post :signup, params: @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'returns unprocessable entity with invalid email' do
        @params[:email] = nil
        post :signup, params: @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it 'returns unprocessable entity with invalid password' do
        @params[:password] = nil
        post :signup, params: @params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end