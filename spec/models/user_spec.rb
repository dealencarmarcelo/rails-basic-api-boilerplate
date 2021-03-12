require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should allow_values('example@email.com', 'email@validemail.com.br', 'email-with_symbol.@email.com').for(:email) }
  it { should_not allow_values('email.example.br', 'example@email@test.com').for(:email) }
  
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_confirmation_of(:password).on(:create) }

  it { should have_secure_password }
end
