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

INSERT INTO posts (title, content) VALUES ('post_1', 'content_1');
INSERT INTO posts (title, content) VALUES ('post_2', 'content_2');

INSERT INTO comments (content, author, post_id) VALUES ('comment_content_1', 'author_1', 1);
INSERT INTO comments (content, author, post_id) VALUES ('comment_content_2', 'author_2', 1);


# require 'artist_repository'

# RSpec.describe ArtistRepository do

#   def reset_artists_table
#     seed_sql = File.read('spec/seeds_artists.sql')
#     connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
#     connection.exec(seed_sql)
#   end
    
#   before(:each) do 
#     reset_artists_table
#   end
  
#   describe "#all" do
#     it "returns the list of artists" do
#       repo = ArtistRepository.new
#       artists = repo.all
      
#       expect(artists.length).to eq 2
#       expect(artists[0].id).to eq "1"
#       expect(artists[0].name).to eq "Pixies"
#       expect(artists[0].genre).to eq "Rock"
#     end
#   end
# end