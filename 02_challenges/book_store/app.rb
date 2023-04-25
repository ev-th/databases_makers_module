require_relative "lib/database_connection"
require_relative "lib/book_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

# # Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |record|
#   p record
# end

repo = BookRepository.new
books = repo.all

books.each_with_index { |book, i| p "#{i + 1} - #{book}" }