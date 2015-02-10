class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	include RatingAverage

	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042, only_integer: true }
	validate :yearcheck


	def yearcheck
	  if year.present? and year > Time.new.year
	    errors.add(:year, " can't be in the future")
    	  end
  	end

end
