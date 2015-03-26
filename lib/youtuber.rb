require 'youtube_it'
require 'faraday'

class Youtuber
  def initialize(access_token, refresh_token)
    @client = connect_to_youtube(access_token, refresh_token)
  end

  def connect_to_youtube(access_token, refresh_token)
    YouTubeIt::OAuth2Client.new(
      client_access_token:  access_token,
      client_refresh_token: refresh_token,
      client_id:            '865537355777-79hfvqidpc9i2e59hv5dirsqilcuqjk8.apps.googleusercontent.com',
      client_secret:        'Hz0QHxq53hnxEG-M2HnnmvD3',
      dev_key:              'AIzaSyAxWGLDTgCv3ftX8EoSW94P7dAgUN48m1Q'
    )
  end

  def create_playlist
    unless has_playlist?
      @client.add_playlist(
        title:       'enova-youtube',
        description: 'generated with ifttt'
      )
    end
  end

  def add_to_playlist(url)
    return unless url.contains? 'youtube'

    create_playlist

    @client.add_video_to_playlist(playlist_id, youtube_id(url))
  end

  def youtube_id(url)
    regex = /youtube.com.*(?:\/|v=)([^&$]+)/
    url.match(regex)[1]
  end

  def playlists
    @client.playlists
  end

  def has_playlist?
    playlists.find_index do |p|
      p.title == @playlist_name
    end
  end

  def playlist_id
    playlist = has_playlist?
    playlists[playlist].playlist_id
  end

  def self.get_token(code)
    conn = Faraday.new(url: 'https://accounts.google.com', ssl: {verify: false}) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.post '/o/oauth2/token', {
      'code'          => code,
      'client_id'     => '865537355777-79hfvqidpc9i2e59hv5dirsqilcuqjk8.apps.googleusercontent.com',
      'client_secret' => 'Hz0QHxq53hnxEG-M2HnnmvD3',
      'redirect_uri'  => 'http://enova-youtube.heroku.com',
      'grant_type'    => 'authorization_code'
    }

    JSON.parse response.body
  end
end
