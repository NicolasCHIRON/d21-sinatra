require 'bundler'
Bundler.require

require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossips
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"].to_i, params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {id: params['id'].to_i, gossip: Gossip.find(params['id'])}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'], gossip: Gossip.find(params['id'])}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params['id'], params["gossip_author"], params["gossip_content"])
    redirect '/'
  end

end