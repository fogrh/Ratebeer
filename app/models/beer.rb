class Beer < ActiveRecord::Base
belongs_to :brewery
belongs_to :style
has_many :ratings, dependent: :destroy
has_many :raters, through: :ratings, source: :user

validates :name, :style, presence: true

include RatingAverage

	

	def to_s
	"#{name} - Brewery: #{brewery.name}"
	end

	
end
