require 'bundler'
require 'gossip'
require 'comment'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"], params["gossip_id"]).save
    redirect '/'
  end

  get '/gossip/:id/' do
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params['name'] is 'foo' or 'bar'
    erb :show, locals: {gossip: Gossip.find(params['id']), comment: Comment.by_id_gossip(params['id'])}
  end

  post '/gossip/:id/' do
    Comment.new(params['id'], params["comment_content"]).save
    redirect '/'
  end

  
  get '/gossips/:id/edit/' do
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params['name'] is 'foo' or 'bar'
    erb :edit, locals: {gossips: Gossip.all, gossip: Gossip.find(params['id'])}
  end
 
  post '/gossips/:id/edit/' do
    Gossip.update(params["gossip_author"], params["gossip_content"], params['id']).save
    redirect '/'
  end
end    