class User < ApplicationRecord
  has_many :user_games
  has_many :games, through: :user_games
  has_many :moves

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
