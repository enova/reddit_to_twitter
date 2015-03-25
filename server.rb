require 'sinatra'
require './lib/youtuber'

class RedditToYoutube < Sinatra::Base
  get '/auth' do
    redirect to 'https://accounts.google.com/o/oauth2/auth' \
      '?client_id=865537355777-79hfvqidpc9i2e59hv5dirsqilcuqjk8.apps.googleusercontent.com' \
      '&redirect_uri=http://enova-youtube.heroku.com' \
      '&response_type=code' \
      '&approval_prompt=force' \
      '&access_type=offline' \
      '&scope=https://gdata.youtube.com'
  end

  get '/' do
    token = Youtuber.get_token(params[:code])

    # 💩
    if token['access_token']
      File.open('.access_token', 'w+')  { |f| f.write(token['access_token']) }
      File.open('.refresh_token', 'w+') { |f| f.write(token['refresh_token']) }
      body 'ok'
    else
      body 'nah'
    end
  end

  post '/' do
    access   = File.read('.access_token')
    refresh  = File.read('.refresh_token')

    youtuber = Youtuber.new(access, refresh)

    # from node app
    data = JSON.parse(params.to_json).to_hash
    url  = data['title']

    youtuber.add_to_playlist(url)

    body 'ok'
  end
end
