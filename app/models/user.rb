class User < ApplicationRecord
  has_many :messages
  before_save { self.username = username.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive:false }
  has_secure_password
end
