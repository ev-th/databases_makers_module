require "pg"
require "tag_repository"

def reset_tables
  sql_seeds = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_posts_tags_test"} )
  connection.exec(sql_seeds)
end

RSpec.describe TagRepository do
  before(:each) do
    reset_tables
  end

  describe "#find_by_post" do
    it "returns an array of tags associated with a specific post" do
      repo = TagRepository.new
      tags = repo.find_by_post(6)

      expect(tags.first.id).to eq "2"
      expect(tags.first.name).to eq "travel"

      expect(tags.last.id).to eq "3"
      expect(tags.last.name).to eq "cooking"
    end
  end
end