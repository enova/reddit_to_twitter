# reddit_to_twitter
Very basic Sinatra application to take posts and upload the titles to their personal twitters

1. Sign up for IFTTT
  - http://ifttt.com/join

2. Download reddit_to_twitter application
  - git clone https://github.com/zgallup/reddit_to_twitter.git
  - cd reddit_to_twitter
  - heroku create

3. Add app to twitter profile
  - https://dev.twitter.com/apps
  - Create New App
    - name: reddit_to_twitter
    - desc: whatever you want
    - website: heroku_URL_for_reddit_to_twitter_application i.e. https://pacific-eyrie-9417.herokuapp.com/
    - callback url: leave blank
  - Save application
  - Select application
    - Change Permissons to Read and Write
    - Update reddit_to_twitter application with your twitter secret keys

4.  Push reddit_to_twitter to Heroku
  - git add .
  - git commit -m 'adding my twitter keys'
  - git push heroku master
