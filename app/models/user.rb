class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password, confirmation: true, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email)

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
