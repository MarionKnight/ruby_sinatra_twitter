# get '/auth/twitter/callback' do
#   # probably you will need to create a user in the database too...
#   session[:uid] = env['omniauth.auth']['uid']
#   # this is the main endpoint to your application
#   redirect to('/')
# end

# get '/auth/failure' do
#   # omniauth redirects to /auth/failure when it encounters a problem
#   # so you can implement this as you please
# end

require 'sinatra'
require 'omniauth'
require 'omniauth-twitter'
require 'debugger' 
require 'twitter'
enable :sessions

use OmniAuth::Builder do
  provider :twitter, "Fa2WTjz0dCij2BmCvL9X2g", "T5QcIwUpvQIHNKcEXqlJF53mOPuvxAiqI7QS4UCbs"
end

get '/' do
  erb :index
end

get '/auth/twitter/callback' do
  # p env['omniauth.auth']
  p params
  session[:user]=Twitter::Client.new(
    :consumer_key => "Fa2WTjz0dCij2BmCvL9X2g",
    :consumer_secret => "T5QcIwUpvQIHNKcEXqlJF53mOPuvxAiqI7QS4UCbs",
    :oauth_token => params["oauth_token"],
    :oauth_token_secret => params["oauth_verifier"]
    )
  p session[:user]
  # debugger
  erb :tweet_form
end

post '/tweet' do
  #
end



get '/auth/failure' do
  flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
  redirect '/'
end