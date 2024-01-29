require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  erb(:homepage)
end

get '/stock' do
  symbol = params['symbol']
  stock_url = "https://cloud.iexapis.com/stable/stock/#{symbol}/quote?token=#{ENV['STOCK_KEY']}"
  news_url = "https://cloud.iexapis.com/stable/stock/#{symbol}/news/last/1?token=#{ENV['STOCK_KEY']}"

  stock_response = HTTP.get(stock_url)
  news_response = HTTP.get(news_url)

  if stock_response.status.success?
    @stock_info = stock_response.parse(:json)
  else
    @error_message = "Unable to fetch stock data."
  end

  if news_response.status.success?
    @news_info = news_response.parse(:json)
  end

  erb :stock
end

