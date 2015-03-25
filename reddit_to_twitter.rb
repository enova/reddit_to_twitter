require 'sinatra'
require 'twitter'

get '/' do
  body 'posts only'
end

post '/' do
  client = connect_to_twitter
  data = JSON.parse(params.to_json).to_hash
  client.update(data['title'])
end

def connect_to_twitter
  Twitter::REST::Client.new do |config|
    config.consumer_key        = 'INSERT_CONSUMER_KEY'
    config.consumer_secret     = 'INSERT_CONSUMER_SECRET'
    config.access_token        = 'INSERT_ACCESS_TOKEN'
    config.access_token_secret = 'INSERT_ACCESS_TOKEN_SECRET'
  end
end
