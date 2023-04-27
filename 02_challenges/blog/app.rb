require_relative "lib/database_connection"
require_relative "lib/post_repository"

DatabaseConnection.connect("blog")

def print_post_with_comments(id)
  repo = PostRepository.new
  post = repo.find_with_comments(id)

  puts post.title
  puts "-" * post.title.length
  puts post.content
  puts "\nCOMMENTS"
  post.comments.each { |comment| puts "  #{comment.author} - #{comment.content}" }
end

print_post_with_comments(2)