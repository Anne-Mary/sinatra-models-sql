class Post
	attr_accessor :id, :title, :body

     #Use Ruby Docs 
	def self.open_connection
		PG.connect( dbname: "blog")
	end

    # This hash with sting keys use e.g ['title'], model is change the data into something easier to understand
	def self.hydrate post_data
		post = Post.new

		post.id = post_data['id']
		post.title = post_data['title']
		post.body = post_data['body']

		post
	end
    
    #
	def self.all 
		conn = self.open_connection
		sql = "SELECT * FROM post ORDER BY id"
		results = conn.exec(sql)

		posts = results.map do |post|
			self.hydrate post
		end
		posts
	end
#
	def self.find id 
		conn = self.open_connection
		sql = "SELECT * FROM post WHERE id = #{id} LIMIT 1"
		#run this and store it in posts
		post = conn.exec(sql)
		self.hydrate post[0]
	end 
    
    # #[This is bascially turning a variable to string]
	def save 
		conn = Post.open_connection
		sql = "INSERT INTO post (title,body)
        VALUES ('#{self.title}', '#{self.body}');"

        conn.exec(sql)
    end

    def update
    	conn = Post.open_connection
    	sql = "UPDATE post SET title='#{self.title}', body='#{self.body}' WHERE id = #{self.id}"
    	conn.exec(sql)
    end

    def self.destroy id
    	conn = self.open_connection 
    	sql = "DELETE FROM post WHERE id = #{id}"
    	
    	conn.exec(sql)
    end
end