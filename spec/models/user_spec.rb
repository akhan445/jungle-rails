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

  describe '.authenticate_with_credentials' do
    before(:example) do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "johndoe@email.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    it "should validate when the correct user credentials are entered" do
      @user.save

      authenticated_user = User.authenticate_with_credentials("johndoe@email.com", "password123")

      expect(authenticated_user).to be_truthy
      expect(authenticated_user).to be_an_instance_of(User)
    end

    it "should return nil if the user is not in the database" do
      @user.save

      authenticated_user = User.authenticate_with_credentials("jillmayer@email.com", "pass1122")

      expect(authenticated_user).to be_nil
    end

    it "should not authenticate a user with wrong password" do
      @user.save

      authenticated_user = User.authenticate_with_credentials("johndoe@email.com", "password1234")

      expect(authenticated_user).to be_nil
    end

    it "should still authenticate a user with leading and/or trailing spaces in email field" do
      @user.save

      authenticated_user = User.authenticate_with_credentials("  johndoe@email.com ", "password123")

      expect(authenticated_user).to be_truthy
      expect(authenticated_user).to be_an_instance_of(User)
    end

    it "should be case insensitive when authenticating a user (ie. example@domain.com == EXAMPLe@DOMAIN.CoM)" do
      @user.save

      authenticated_user = User.authenticate_with_credentials("joHNdoe@email.coM", "password123")

      expect(authenticated_user).to be_truthy
      expect(authenticated_user).to be_an_instance_of(User)
    end
  end
end
