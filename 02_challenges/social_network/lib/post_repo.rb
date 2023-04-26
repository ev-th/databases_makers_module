class PostRepo
  def all
    posts = []

    sql = "SELECT * FROM posts;"
    records = DatabaseConnection.exec_params(sql, [])

    records.each do |record|
      post = Post.new

      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.number_of_views = record['number_of_views']
      post.user_account_id = record['user_account_id']
      
      posts << post
    end
    
    return posts
  end
  
  def find(id)
    sql = "SELECT * FROM posts WHERE id = $1;"
    
    record = DatabaseConnection.exec_params(sql, [id]).first
    
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.number_of_views = record['number_of_views']
    post.user_account_id = record['user_account_id']

    return post
  end

  def create(post)
    sql = "INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);"

    params = [post.title, post.content, post.number_of_views, post.user_account_id]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1;"

    DatabaseConnection.exec_params(sql, [id])
  end

  def update(id, post)
    post_old = find(id)

    title = post.title.nil? ? post_old.title : post.title
    content = post.content.nil? ? post_old.content : post.content
    number_of_views = post.number_of_views.nil? ? post_old.number_of_views : post.number_of_views
    user_account_id = post.user_account_id.nil? ? post_old.user_account_id : post.user_account_id

    params = [id, title, content, number_of_views, user_account_id]

    sql = "UPDATE posts SET title=$2, content=$3, number_of_views=$4, user_account_id=$5
      WHERE id=$1;"

    DatabaseConnection.exec_params(sql, params)
  end
end