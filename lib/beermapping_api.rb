class BeermappingApi

 	def self.places_in(city)
 	return [] if city.nil? or city.empty?
     	city = city.downcase
    	Rails.cache.fetch(city, expires_in: 5.days) { fetch_places_in(city) }
  	end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end
=begin
  def self.fetch_place(id)
	url = "http://beermapping.com/webservice/locquery/#{key}/"
	response = HTTParty.get "#{url}#{ERB::Util.url_encode(id)}"
	places = response.parsed_response["bmp_locations"]["location"]
	return nil if places['id'].nil?
	Place.new
=end
  def self.key
    raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end

  def self.gkey #Google api key
  "AIzaSyA8QlwYJpCMFJTFovoupnJ67qCF_uC3X_s"
  end
end


