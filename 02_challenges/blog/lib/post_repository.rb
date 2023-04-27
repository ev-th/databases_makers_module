require_relative "./database_connection"
require_relative "./post"
require_relative "./comment"

class PostRepository
  def find_with_comments(id)
    sql = "SELECT posts.id AS post_id,
        title,
        posts.content AS posts_content,
        comments.id AS comments_id,
        comments.author AS comments_author,
        comments.content AS comments_content,
        author
      FROM posts JOIN comments
        ON posts.id = comments.post_id
      WHERE posts.id = $1;"

    records = DatabaseConnection.exec_params(sql, [id])

    post = Post.new
    post.id = records.first["post_id"]
    post.title = records.first["title"]
    post.content = records.first["posts_content"]

    post.comments = []
    records.each do |record|
      # binding.irb
      comment = Comment.new
      comment.id = record["comments_id"]
      comment.content = record["comments_content"]
      comment.author = record["comments_author"]
      comment.post_id = record["post_id"]
      post.comments << comment
    end

    return post
  end
end