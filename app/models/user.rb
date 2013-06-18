class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_many :items

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, if: -> (u) { u.password.present? } }
end
