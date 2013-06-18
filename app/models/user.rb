class User < ActiveRecord::Base
  has_many :items

  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, if: -> (u) { u.password.present? } }
end
