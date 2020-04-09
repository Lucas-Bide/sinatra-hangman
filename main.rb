require 'sinatra'
require_relative 'public/lib/hangman.rb'

enable :sessions

game = Hangman.new

get '/hangman' do
  erb :index, locals: {game: game, message: session.delete(:message)}
end

post '/hangman' do
  guess = params[:guess].downcase if params[:guess]
  if params[:restart]
    game = Hangman.new
    redirect '/hangman'
  elsif game.valid_guess?(guess)
    game.guess(guess)
    session[:message] = game.result if game.game_over?
    redirect '/hangman'
  else
    session[:message] = "Enter a letter that hasn't been guessed yet!"
    erb :index, locals: {game: game, message: session.delete(:message)}
  end
end