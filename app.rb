require 'sinatra'
require_relative 'board_class.rb'
require_relative 'player_class.rb'
# require_relative 'game_class.rb'
enable :sessions

get '/' do
  erb :start_page
end

post '/start_page' do
	session[:difficulty] = params[:difficulty]
	redirect '/game_play'
end

get '/game_play' do
	difficulty = session[:difficulty] || ""
	erb :game_play, locals: {difficulty: difficulty}
end

