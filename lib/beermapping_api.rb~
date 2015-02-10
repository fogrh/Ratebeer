class BeermappingApi
  def self.places_in(city)

 return [] if city.nil? or city.empty?
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
   end

  def self.key
    "787df5c281a61a5f564f1211c4a513a3"
  end
end
