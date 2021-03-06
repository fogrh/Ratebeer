class Beer < ActiveRecord::Base
belongs_to :brewery, touch: true
belongs_to :style
has_many :ratings, dependent: :destroy
has_many :raters, through: :ratings, source: :user

validates :name, :style, presence: true

include RatingAverage

	

	def to_s
	"#{name} - Brewery: #{brewery.name}"
	end
	def self.top(n)
	sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
	sorted_by_rating_in_desc_order[0..(n-1)]
	end
	
end
