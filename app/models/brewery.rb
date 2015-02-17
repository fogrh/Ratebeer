class Brewery < ActiveRecord::Base
include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

 	validates :year, numericality: { less_than_or_equal_to: ->(_) { Time.now.year} }
	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042, only_integer: true }

  	scope :active, -> { where active:true }
  	scope :retired, -> { where active:[nil,false] }

	def to_s
	"#{self.name}"
	end

	def self.top
	top_ratings(3)
	end


end
