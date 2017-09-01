require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

require_relative'./models/post.rb'
require_relative './controllers/posts_controller.rb'
# overriding the _method, which is on the "edit.rb" 
use Rack::MethodOverride
run PostsController