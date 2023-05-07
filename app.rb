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
	erb :index
end

get '/newPost' do
	erb :newPost

end

post '/newPost' do
	p = Post.new params[:post]
	p.save
	if p.save 
		erb "Your new post has been added successfully"
	else
		p.errors.full_messages.first
		erb :newPost
	end
end

get '/details/:post_id' do
	@post = Post.find(params[:post_id])

	erb :newComment
  end