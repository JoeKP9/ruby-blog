class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates_presence_of :username, length: { minimum: 5 }
  has_many :likes, dependent: :destroy
end
