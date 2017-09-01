class PostsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") } 

  configure :development do
      register Sinatra::Reloader
  end
# Params you get from a URl or form
 #I don't know why we use the dollar sign (now I do)
  $posts = [{
      id: 0,
      title: "Post 1",
      body: "This is the first post"
  },
  {
      id: 1,
      title: "Post 2",
      body: "This is the second post"
  },
  {
      id: 2,
      title: "Post 3",
      body: "This is the third post"
  }];  
  
  post '/' do
    
    "CREATE"
    new_post = Post.new()

    new_post.body = params[:body]
    new_post.title = params[:title]

    new_post.save
    redirect "/"
    
  end
    
 #Where is the word "Post" coming from, 2 mins later Anne realises it's from the class post on post.rb
  get '/' do

      @title = "Blog posts"

      @posts = Post.all
     
      erb :'posts/index'
  
  end

 get '/new'  do
    erb :'posts/new'
  
  end
 
  get '/:id' do
    
    # get the ID and turn it in to an integer
    id = params[:id].to_i
    # make a single post object available in the template
    @post = Post.find id

    erb :'posts/show'
    
  end
    
  put '/:id'  do
    # data is gathered in the params object
    id = params[:id].to_i
      
    # load the object with the id
    post = Post.find id

    # update the values
    post.title = params[:title]
    post.body = params[:body]

    # save the post
    post.update
      
    # redirect the user to a GET route. We'll go back to the INDEX.
    redirect "/";
   
  end
    
  delete '/:id'  do

    id = params[:id].to_i

    Post.destroy(id)

    redirect "/"
    
    "DELETE: #{params[:id]}"
    
  end
    
 
  get '/:id/edit' do

    id = params[:id].to_i

    @post = Post.find id 

    erb :'posts/edit'
  end

end