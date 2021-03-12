require_relative "api_spec_helper"

describe Api::V1::UsersController do 
  before do
    3.times do
      FactoryBot.create(:user)
    end
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
    it 'returns list of users' do
      get api_v1_users_path
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(User.count)
    end
    it 'return valid data' do
      get api_v1_users_path
      expect(json).to be_truthy
    end
  end

  describe '#show' do
    context 'with valid user' do
      it 'return user' do
        get api_v1_user_path(@user.id)
        expected = @user.as_json
        expect(response).to have_http_status(:success)
        expect(json).to eq(expected)
      end
    end
    it 'return not_found on an invalid id' do
      get api_v1_user_path(0)
      validate_api_error(response, 404, 'not_found')
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'create an user' do
        post api_v1_users_path, params: @params
        expected = User.last.as_json
        expect(response).to have_http_status(:success)
        expect(json).to eq(expected)
      end
      it 'add users count' do
        expect {
          post api_v1_users_path, params: @params
        }.to change { User.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns record invalid without a name' do
        @params[:name] = nil
        # post api_v1_users_path, params: @params
        
        expect {
          post api_v1_users_path, params: @params
        }.to change { User.count }.by(0)
        expect(response).to have_http_status(422)
      end
      it 'returns record invalid without a email' do
        @params[:email] = nil
        # post api_v1_users_path, params: @params
        
        expect {
          post api_v1_users_path, params: @params
        }.to change { User.count }.by(0)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'succeeds' do
        @params[:name] = Faker::Name.name
        put api_v1_user_path(@user.id), params: { name: Faker::Name.name }
        expected = User.find_by(id: @user.id).as_json
        expect(response).to have_http_status(:success)
        expect(json).to eq(expected)
      end
    end

    context 'with invalid params' do
      it 'returns not found with invalid user_id' do
        put api_v1_user_path(0), params: { name: Faker::Name.name }
        validate_api_error(response, 404, 'not_found')
      end
      it 'returns record invalid with nil name' do
        put api_v1_user_path(@user.id), params: { name: nil }
        expect(response).to have_http_status(422)
      end
      it 'returns record invalid with nil email' do
        put api_v1_user_path(@user.id), params: { email: nil }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#destroy' do
    context 'with valid params' do
      it 'succeeds' do
        delete api_v1_user_path(@user.id)
        expect(response).to have_http_status(:no_content)
      end
      it 'destroy an user' do
        expect {
          delete api_v1_user_path(@user.id)
        }.to change { User.count }.by(-1)
      end
    end

    context 'with invalid params' do
      it 'returns not_found with invalid user_id' do
        delete api_v1_user_path(0)
        validate_api_error(response, 404, 'not_found')
      end
    end
  end
end