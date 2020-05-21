class BingSearchController < ApplicationController

require 'net/http'

ACCESS_KEY = '13f5b67986cd4c1399d962691f8ec0e1'
URL = 'https://api.cognitive.microsoft.com/bing/v7.0/search'
	def index

		@results = search('日本')
		
	end

	private

	def search(term)
		uri = URI("#{URL}?q=#{URI.escape(term)}")
		request = Net::HTTP::Get.new(uri)
		request['Ocp-Apim-Subscription-Key'] = ACCESS_KEY

		response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
			http.request(request)
	end
	JSON(response.body)
end
end