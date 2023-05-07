#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "leprosorium.db"}

class Post < ActiveRecord::Base
	validates :postText, presence: true
	
end

class Comment < ActiveRecord::Base
end

before do
	@posts = Post.all
	@comments = Comment.all
end


get '/' do
	@posts = Post.order('created_at DESC')
	erb :index
end

get '/newPost' do
	@p = Post.new 
	erb :newPost

end

post '/newPost' do
	@p = Post.new params[:post]
	@p.save
	if @p.save 
		erb "Your new post has been added successfully"
	else
		@error = @p.errors.full_messages.first
		erb :newPost
	end
end

get '/details/:post_id' do
	@post = Post.find(params[:post_id])
	
	erb :details
  end

post '/details/:post_id' do
@c = Comment.new params[:comment]
	if @c.save
		erb "Thanks. You've been enrolled now"
	else
		@error = @c.errors.full_messages.first
		erb :details
	end
end

  