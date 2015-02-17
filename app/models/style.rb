class Style < ActiveRecord::Base
	include RatingAverage
	has_many :beers

	validates :beerstyle, presence: true

	def to_s
	self.beerstyle
	end

	def self.most_rated(n)
	sorted = Style.all.sort_by{ |b| -(b.ratings.count ||0) }
	sorted.take(n)
	end
end
