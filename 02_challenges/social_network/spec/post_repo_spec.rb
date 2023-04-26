require 'post_repo'
require 'post'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end
  
describe PostRepo do
  before(:each) do 
    reset_tables
  end

  describe "#all" do
    it "returns all records from the posts table" do
      repo = PostRepo.new
      posts = repo.all
      
      expect(posts.length).to eq 1
      expect(posts.first.id).to eq "1"
      expect(posts.first.title).to eq "Post 1"
      expect(posts.first.content).to eq "Some content"
      expect(posts.first.number_of_views).to eq "2"
      expect(posts.first.user_account_id).to eq "1"
    end
  end
  
  describe "#find" do
    it "returns a single post from the posts table" do
      repo = PostRepo.new
      
      post = repo.find(1)
      
      expect(post.id).to eq "1"
      expect(post.title).to eq "Post 1"
      expect(post.content).to eq "Some content"
      expect(post.number_of_views).to eq "2"
      expect(post.user_account_id).to eq "1"
    end
  end
  
  describe "#create" do
    it "creates a new post in the post table" do
      repo = PostRepo.new
      
      new_post = Post.new
      new_post.title = "Post 2"
      new_post.content = "More content"
      new_post.number_of_views = 9001
      new_post.user_account_id = 2
      
      repo.create(new_post)
      
      posts = repo.all
      
      post = posts.last
      
      expect(posts.length).to eq 2
      expect(post.id).to eq "2"
      expect(post.title).to eq "Post 2"
      expect(post.content).to eq "More content"
      expect(post.number_of_views).to eq "9001"
      expect(post.user_account_id).to eq "2"
    end
  end
  
  describe "#delete" do
    it "deletes a post from the table" do
      repo = PostRepo.new
      
      repo.delete(1)
      
      records = repo.all
      
      expect(records.length).to eq 0
    end
  end
  
  describe "#update" do
    it "updates one attribute of a post in the table by id" do
      post = Post.new
      post.number_of_views = 5

      repo = PostRepo.new
      repo.update(1, post)

      posts = repo.all
      
      expect(posts.first.id).to eq "1"
      expect(posts.first.title).to eq "Post 1"
      expect(posts.first.content).to eq "Some content"
      expect(posts.first.number_of_views).to eq "5"
      expect(posts.first.user_account_id).to eq "1"
    end

    it "updates multiple attributes of a post in the table by id" do
      post = Post.new
      post.content = "New content"
      post.number_of_views = 5

      repo = PostRepo.new
      repo.update(1, post)

      posts = repo.all
      
      expect(posts.first.id).to eq "1"
      expect(posts.first.title).to eq "Post 1"
      expect(posts.first.content).to eq "New content"
      expect(posts.first.number_of_views).to eq "5"
      expect(posts.first.user_account_id).to eq "1"
    end
  end
end