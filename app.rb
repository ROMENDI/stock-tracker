require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  erb(:homepage)
end

get '/stock' do
  symbol = params['symbol']
  api_url = "https://cloud.iexapis.com/stable/stock/#{symbol}/quote?token=#{ENV["STOCK_KEY"]}"
  response = HTTP.get(api_url)

  if response.status.success?
    @stock_info = response.parse(:json)
  else
    @error_message = "Unable to fetch stock data."
  end
  
  erb(:stock)
end 
