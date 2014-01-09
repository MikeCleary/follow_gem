require 'sinatra'
require 'pry'

class MyAmazingService < Sinatra::Base

  configure do 
    ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3", 
      :database => "db/followers.sqlite3"
    )
  end

  options '/*' do
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin, Content-Type'
    200
  end

  get '/' do
    ' hello'.lively
  end

  get "/users/:followed_id/follows" do
    follows = Follow.where(:users_followed_id => params[:followed_id])
    @followers = []
    follows.each do |follow|
      @followers << User.find(follow.users_following_id)
    end
    content_type :json
    @followers.to_json
  end

  post '/users/:followed_id/follows/:follower_id' do
    @follow = Follow.new(
      :users_followed_id => params[:followed_id],
      :users_following_id => params[:follower_id]
    )
    if Follow.where(:users_following_id => @follow.users_following_id)
      @follow.save!
      @follower = User.find(@follow.users_following_id)
    else
      new_follower = HTTParty.get "http://localhost:3000/users/#{@follow.users_following_id}"
      @follower = User.create!(:first_name => new_follower['first_name'], :last_name => new_follower['last_name'], :image_url => new_follower['image_url'], :user_id => new_follower['id'].to_i)
    end
    content_type :json
    @follower.to_json
  end
end