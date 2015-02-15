class Style < ActiveRecord::Base
	has_many :beers

	validates :beerstyle, presence: true

	def to_s
	self.beerstyle
	end
end
