class CheckYear < ActiveRecord::Base
	validate :yearcheck, on: :update

	def yearcheck
	  if year.present? and year > Time.now.year
	    errors.add(:year, "The year can't be in the future")
    	  end
  	end
