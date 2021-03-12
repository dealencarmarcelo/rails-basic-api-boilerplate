require 'rails_helper'

describe UsersController, type: :controller do 
  before do
    3.times do
      FactoryBot.create(:user)
    end
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
    it 'returns list of users' do
      get :index
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(User.count)
    end
    it 'return valid data' do
      get :index
      expect(json_data).to be_truthy
    end
  end

  describe '#show' do
    context 'with valid user' do
      it 'return user' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(:success)
        expect(json).to have_attributes(@user.as_json)
      end
    end
    it 'return not_found on an invalid id' do
      get :show, params: { id: 0 }
      validate_api_error(response, 404, 'not_found')
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'create an user' do
        post :create, params: @params
        expect(response).to have_http_status(:success)
        expect(json).to have_attributes(User.last.as_json)
      end
      it 'add users count' do
        expect {
          post :create, params: @params
        }.to change { User.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns record invalid without a name' do
        @params[:name] = nil
        post :create, params: @params
        validate_api_error(response, 422, 'record_invalid')

        expect {
          post :create, params: @params
        }.to_not change { User.count }.by(1)
      end
      it 'returns record invalid without a email' do
        @params[:email] = nil
        post :create, params: @params
        validate_api_error(response, 422, 'record_invalid')

        expect {
          post :create, params: @params
        }.to_not change { User.count }.by(1)
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'succeeds' do
        @params[:name] = Faker::Name.full_name
        put :update, params: { id: @user.id, name: Faker::Name.full_name }
        expect(response).to have_http_status(:success)
        expect(json).to have_attributes(User.find_by(id: @user.id).as_json)
      end
    end

    context 'with invalid params' do
      it 'returns not found with invalid user_id' do
        put :update, params: { id: 0, name: Faker::Name.full_name }
        validate_api_error(response, 404, 'not_found')
      end
      it 'returns record invalid with nil name' do
        put :update, params: { id: @user.id, name: nil }
        validate_api_error(response, 422, 'record_invalid')
      end
      it 'returns record invalid with nil email' do
        put :update, params: { id: @user.id, email: nil }
        validate_api_error(response, 422, 'record_invalid')
      end
    end
  end

  describe '#destroy' do
    context 'with valid params' do
      it 'succeeds' do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status(:no_content)
      end
      it 'destroy an user' do
        expect {
          pdelete :destroy, params: { id: @user.id }
        }.to change { User.count }.by(-1)
      end
    end

    context 'with invalid params' do
      it 'returns not_found with invalid user_id' do
        delete :destroy, params: { id: 0 }
        validate_api_error(response, 404, 'not_found')
      end
    end
  end
end