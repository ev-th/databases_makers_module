require "post_repository"
require "pg"

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_posts_tags_test" })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_tables
  end

  describe "#find_by_tag" do
    it "returns a list of posts matching a tag" do
      post_repository = PostRepository.new
      posts = post_repository.find_by_tag("coding")

      expect(posts[0].id).to eq "1"
      expect(posts[1].id).to eq "2"
      expect(posts[2].id).to eq "3"
      expect(posts[3].id).to eq "7"

      expect(posts[0].title).to eq "How to use Git"
      expect(posts[1].title).to eq "Ruby classes"
      expect(posts[2].title).to eq "Using IRB"
      expect(posts[3].title).to eq "SQL basics"
    end
  end
end