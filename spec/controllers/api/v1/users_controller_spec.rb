require 'rails_helper'

describe UsersController, type: :controller do 
  before do
    @user = FactoryBot.create(:user)

    password = Faker::Alphanumeric.alphanumeric(number: 8)
    @params = {
      name: Faker::Name.full_name,
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
      # it 'creates an user and return success' do
      #   expect {
      #     post :create, params: @params
      #   }.to change { User.count }.by(1)
      # end
    end

    context 'with invalid params' do
      it 'returns record invalid' do
        @params[:name] = nil
        post :create, params: @params
        expect(response).to have_http_status(:record_invalid)
      end

      # it 'does not create an user' do
      #   expect {
      #     post :create, params: @params
      #   }.to_not change { User.count }.by(1)
      # end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'succeeds' do
        @params[:name] = Faker::Name.full_name
        post :update, params: @params
        expect(response).to have_http_status(:success)
      end
      # it 'update an user' do
      #   @params[:name] = Faker::Name.full_name
      #   post :update, params: @params
      #   expect(json['name']).to eq(@params[:name])
      # end
    end

    context 'with invalid params' do
      it 'returns not_found with invalid user' do
        post :update, params: { id: 0, name: Faker::Name.full_name }
        expect(response).to have_http_status(:not_found)
      end
      it 'returns record_invalid with nil attribute' do
        @params[:name] = nil
        post :update, params: @params
        expect(response).to have_http_status(:record_invalid)
      end
    end
  end

  describe '#destroy' do
    context 'with valid params' do
      it 'succeeds' do
        post :destroy, params: { id: @params.id }
        expect(response).to have_http_status(:no_content)
      end
      # it 'destroy an user' do
      #   expect {
      #     post :create, params: @params
      #   }.to change { User.count }.by(-1)
      # end
    end

    context 'with invalid params' do
      it 'returns not_found' do
        post :destroy, params: @params
        expect(response).to have_http_status(:not_found)
      end

      # it 'does not destroy an user' do
      #   expect {
      #     post :create, params: @params
      #   }.to_not change { User.count }.by(-1)
      # end
    end
  end
end