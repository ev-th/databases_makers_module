require "account"

class AccountRepo
  def all
    accounts = []

    sql = "SELECT * FROM user_accounts;"
    records = DatabaseConnection.exec_params(sql, [])

    records.each do |record|
      account = Account.new
      account.id = record["id"]
      account.email_address = record["email_address"]
      account.username = record["username"]
      accounts << account
    end
    
    return accounts
  end
  
  def find(id)
    sql = "SELECT * FROM user_accounts WHERE id = $1;"
    result = DatabaseConnection.exec_params(sql, [id]).first

    account = Account.new
    account.id = result["id"]
    account.email_address = result["email_address"]
    account.username = result["username"]

    return account
  end

  def create(account)
    sql = "INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);"

    params = [account.email_address, account.username]

    DatabaseConnection.exec_params(sql, params)
  end
  
  def delete(id)
    sql =  "DELETE FROM user_accounts WHERE id = $1;"

    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end
  
  def update(account)
    sql = "UPDATE user_accounts SET email_address = $2, username = $3 WHERE id = $1;"
    
    params = [account.id, account.email_address, account.username]
    
    DatabaseConnection.exec_params(sql, params)
  end
end