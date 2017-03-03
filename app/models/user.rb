class User < ApplicationRecord
  before_create :generate_auth_token!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

   validates :auth_token, uniqueness: true
   has_many :products, dependent: :destroy
   has_many :orders

   def generate_auth_token!
       begin
           self.auth_token = Devise.friendly_token
       end while self.class.exists?(auth_token: self.auth_token)
   end
end
