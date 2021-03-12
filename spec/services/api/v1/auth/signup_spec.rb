require 'rails_helper'

describe Api::V1::Auth::SignupService do
  subject(:context) { described_class.call(auth_params) }

  describe '.call' do
    context 'with valid params' do
      password = Faker::Alphanumeric.alphanumeric(number: 8)
      let(:auth_params) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: password,
          password_confirmation: password
        }
      end
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'with invalid params' do
      password = Faker::Alphanumeric.alphanumeric(number: 8)
      let(:auth_params) do
        {
          name: nil,
          email: Faker::Internet.email,
          password: password,
          password_confirmation: password
        }
      end
      it 'fails' do
        expect{
          context
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end