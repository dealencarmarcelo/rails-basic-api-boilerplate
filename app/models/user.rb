class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :email
  validates :password, length: { minimum: 6 }, presence: true,
                        if: :password

  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_uniqueness_of :email, case_sensitive: false
end
