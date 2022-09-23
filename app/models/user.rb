class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :validate_password_length

  has_many :reservations
  enum :role, %i[user manager admin]

  def validate_password_length
    errors.add(:password, :too_long, message: 'Password is too long') if password.nil? || password.bytesize > 72
  end
end
