require 'account_repo'
require 'account'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end
  
describe AccountRepo do
  before(:each) do 
    reset_tables
  end

  describe "#all" do
    it "returns all records from the accounts table" do
      repo = AccountRepo.new
      accounts = repo.all
      
      expect(accounts.length).to eq 2
      expect(accounts.first.id).to eq "1"
      expect(accounts.first.email_address).to eq "Email 1"
      expect(accounts.first.username).to eq "User 1"

      expect(accounts.last.id).to eq "2"
      expect(accounts.last.email_address).to eq "Email 2"
      expect(accounts.last.username).to eq "User 2"
    end
  end
  
  describe "#find" do
    it "returns a single account from the accounts table" do
      repo = AccountRepo.new
      
      account = repo.find(1)
      
      expect(account.id).to eq "1"
      expect(account.email_address).to eq "Email 1"
      expect(account.username).to eq "User 1" 
      
      account = repo.find(2)
      
      expect(account.id).to eq "2"
      expect(account.email_address).to eq "Email 2"
      expect(account.username).to eq "User 2" 
    end
  end
  
  describe "#create" do
    it "creates a new account in the accounts table" do
      repo = AccountRepo.new
      
      account = Account.new
      account.email_address = "Email 3"
      account.username = "User 3"
      
      repo.create(account)
      
      accounts = repo.all
      
      expect(accounts.last.id).to eq "3"
      expect(accounts.last.email_address).to eq "Email 3"
      expect(accounts.last.username).to eq "User 3"
    end
  end
  
  describe "#delete" do
    it "deletes a user from the accounts table" do
      repo = AccountRepo.new
      repo.delete(1)
      
      records = repo.all
      remaining_user = records.first
      
      expect(records.length).to eq 1
      
      expect(remaining_user.id).to eq "2"
      expect(remaining_user.email_address).to eq "Email 2"
      expect(remaining_user.username).to eq "User 2"
    end
  end
  
  describe "#update" do
    it "updates a user on the accounts table" do
      account = Account.new
      account.id = 2
      account.email_address = "Email 2.1"
      account.username = "User 2"
      
      repo = AccountRepo.new
      repo.update(account)
      
      account = repo.find(2)
      
      expect(account.email_address).to eq "Email 2.1"
      expect(account.username).to eq "User 2" 
    end
  end
end