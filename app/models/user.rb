class User < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :genres, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
