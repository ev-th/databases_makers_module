require_relative "lib/database_connection"
require_relative "lib/post_repository"

DatabaseConnection.connect("blog_posts_tags")

repo = PostRepository.new
posts = repo.find_by_tag("coding")

posts.each { |post| puts "#{post.id} #{post.title}" }