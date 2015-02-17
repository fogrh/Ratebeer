module RatingAverage

	def average_rating
	ratings.average(:score).to_f
	end


	def top_rated(classname,n)
 	all = classname.all.sort_by{ |b| -(b.average_rating||0) }
	all.take(n)
	end
	def top_rated(n)
	classname= self.class
 	all = classname.all.sort_by{ |b| -(b.average_rating||0) }
	all.take(n)
	end
end
