require 'sinatra'

get '/hangman' do
  erb :index
end

post '/hangman' do
  redirect '/hangman'
end