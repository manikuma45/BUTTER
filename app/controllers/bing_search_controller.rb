class BingSearchController < ApplicationController

require 'net/http'

SEARCH_ACCESS_KEY = '13f5b67986cd4c1399d962691f8ec0e1'
SEARCH_URL = 'https://api.cognitive.microsoft.com/bing/v7.0/news/search'

TRANSLATE_ACCESS_KEY = '37e2922f02224e12a74a2bd61b859f2c'
TRANSLATE_URL = 'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0'
	def index
		@query = params[:q] ?  params[:q] : ''

		@lang = params[:lang] ? params[:lang] : 'ja'

		@results = search

		@results = translate unless @lang == 'ja'
		
	end

	private

	def translate
		@results['value'].each do |news|
		 news['name'], news['description'] = translate_news(news)
		end

		@results
	end

	def translate_news(news)
		body = "[{'Text': '#{news['name']}' }, {'Text': '#{news['description']}'}]"

		uri = URI("#{TRANSLATE_URL}&to=#{@lang}")

		request = Net::HTTP::Post.new(uri)
		request['Content-type'] = 'application/json'
		request['content-lenght'] =  body.length
		request['Ocp-Apim-Subscription-Key'] = TRANSLATE_ACCESS_KEY
		request.body = body
		response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
			http.request(request)
		end

		result = response.body.force_encoding('utf-8')
		json = JSON.parse(result)

		return sentence unless json

		[json[0]['translations'][0]['text'], json[1]['translations'][0]['text']]
	end


	def search
		uri = URI("#{SEARCH_URL}?q=#{URI.escape(@query)}")
		request = Net::HTTP::Get.new(uri)
		request['Ocp-Apim-Subscription-Key'] = SEARCH_ACCESS_KEY

		response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
			http.request(request)
	end
	JSON(response.body)
end
end