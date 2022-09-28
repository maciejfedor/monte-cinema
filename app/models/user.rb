class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validate :validate_password_length

  has_many :reservations
  enum :role, { user: 0, manager: 1, admin: 2 }

  def validate_password_length
    errors.add(:password, :too_long, message: 'Password is too long') if password.nil? || password.bytesize > 72
  end
end
