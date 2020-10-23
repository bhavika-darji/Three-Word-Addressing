class WelcomeController < ApplicationController

	def index
		if params[:search] == ""
			if params[:search].match(/\s*(?:(?:\b[a-zA-Z]+\b)[.]*){3}/)
				url = "https://api.what3words.com/v3/convert-to-coordinates?words=#{params[:search]}&key=EXV04VUN"
  			data = JSON.parse(Net::HTTP.get(URI.parse(url)))
				lat = data['coordinates']['lat']
				lng = data['coordinates']['lng']
				coordinates = [lat,lng]
				@results = Geocoder.search(coordinates)
				@wordaddress = "You've searched by 3word address!"
			else
				@results = Geocoder.search(params[:search])
				url = "https://api.what3words.com/v3/convert-to-3wa?coordinates=#{@results.first.coordinates[0]}%2C#{@results.first.coordinates[1]}&key=EXV04VUN"
				data = JSON.parse(Net::HTTP.get(URI.parse(url)))
				@wordaddress = data['words'].tr('"', '')
			end
		else
			@results = Geocoder.search("Calgary, Alberta")
		end
	end
end
