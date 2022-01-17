require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:example) do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "johndoe@email.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    it "is valid with all fields set" do
      expect(@user).to be_valid
    end

    it "is not valid without first_name field" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without last_name field" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without email field" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without password field" do
      @user.password = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without password_confirmation field" do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it "requires email to be unique" do
      @user.save
      user_with_same_email = @user.dup
      expect(user_with_same_email).to_not be_valid
    end

    it "requires email to be unique and case insensitive" do
      @user.save
      user_with_same_email = @user.dup
      user_with_same_email.email = "johnDOE@email.com"
      expect(user_with_same_email).to_not be_valid
    end
    
    it "must have the password and password_confirmation fields match" do
    
      @user.password = "12345"
      @user.password_confirmation = "123456"
      expect(@user).to_not be_valid
    end
    it "should not let you set a password that is less than 6 characters" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user).to_not be_valid
    end

    it "should be valid if passwords match and are >= 6 characters" do
      @user.password = "pass1234"
      @user.password_confirmation = "pass1234"
      expect(@user).to be_valid
    end

  end
end
