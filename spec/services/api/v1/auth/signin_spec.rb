require 'rails_helper'

describe Api::V1::Auth::SigninService do
  subject(:context) { described_class.call(auth_params) }

  describe '.call' do
    context 'with valid params' do
      user = FactoryBot.create(:user)
      let(:auth_params) do
        {
          email: user.email,
          password: user.password
        }
      end
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'with invalid params' do
      user = FactoryBot.create(:user)
      let(:auth_params) do
        {
          email: Faker::Internet.email,
          password: user.password
        }
      end
      it 'fails' do
        expect{
          context
        }.to raise_error ErrorHandler
      end
    end
  end
end