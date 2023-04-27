require "post_repository"

RSpec.describe PostRepository do

  def reset_tables
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: "127.0.0.1", dbname: "blog_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  describe "#find_with_comments" do
    it "returns a Post object with a list of Comments" do
      repo = PostRepository.new
      post = repo.find_with_comments(1)

      expect(post.id).to eq "1"
      expect(post.title).to eq "post_1"
      expect(post.content).to eq "content_1"

      expect(post.comments.first.id).to eq "1"
      expect(post.comments.first.content).to eq "comment_content_1"
      expect(post.comments.first.author).to eq "author_1"
      expect(post.comments.first.post_id).to eq "1"

      expect(post.comments.last.id).to eq "2"
      expect(post.comments.last.content).to eq "comment_content_2"
      expect(post.comments.last.author).to eq "author_2"
      expect(post.comments.last.post_id).to eq "1"
    end
  end
end