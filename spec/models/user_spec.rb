require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password and password_confirmation fields' do
      user = User.new(
        password: 'password',
        password_confirmation: 'password',
        email: 'test@test.com',
        first_name: 'Adam',
        last_name: 'Mcphee'
      )
      expect(user.valid?).to be true
    end

    it 'requires password and password_confirmation to match' do
      user = User.new(
        password: 'password',
        password_confirmation: 'different_password',
        email: 'test@test.com',
        first_name: 'Adam',
        last_name: 'Mcphee'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires password and password_confirmation to be present' do
      user = User.new
      user.valid?
      expect(user.errors[:password]).to_not be_empty
      expect(user.errors[:password_confirmation]).to_not be_empty
    end

    it 'requires email to be unique (case-insensitive)' do
      existing_user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Adam',
        last_name: 'Mcphee'
      )

      user = User.new(
        email: 'TEST@TEST.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bill',
        last_name: 'MacFee'
      )

      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'requires email, first name, and last name to be present' do
      user = User.new
      user.valid?
      expect(user.errors[:email]).to_not be_empty
      expect(user.errors[:first_name]).to_not be_empty
      expect(user.errors[:last_name]).to_not be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Adam',
        last_name: 'McPHEE'
      )
    end

    it 'returns an instance of the user if successfully authenticated' do
      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).to eq(@user)
    end

    it 'returns nil if not successfully authenticated' do
      user = User.authenticate_with_credentials('test@test.com', 'blahblah')
      expect(user).to be_nil
    end

    it 'strips leading and trailing whitespaces from the email' do
      user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(user).to eq(@user)
    end

    it 'ignores case sensitivity in email' do
      user = User.authenticate_with_credentials('TEST@test.com', 'password')
      expect(user).to eq(@user)
    end
  end
end