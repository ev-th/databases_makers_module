require_relative "./database_connection"
require_relative "./book"

class BookRepository
  def all
    sql = "SELECT id, title, author_name FROM books;"
    records = DatabaseConnection.exec_params(sql, [])

    books = []

    records.each do |record|
      book = Book.new
      book.id = record["id"]
      book.title = record["title"]
      book.author_name = record["author_name"]
      books << book
    end

    return books
  end
end