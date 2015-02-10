class User < ActiveRecord::Base
	include RatingAverage
	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :clubs, through: :memberships, source: :beer_club
	has_secure_password

	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{4,}\z/, message: "Password must contain atleast one uppercase letter, a number and be longer than 3 characters." }

	
	
end
