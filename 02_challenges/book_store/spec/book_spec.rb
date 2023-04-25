require "book"

RSpec.describe Book do
  it "can be formatted as a string" do
    book = Book.new
    book.id = "1"
    book.title = "title_1"
    book.author_name = "author_name_1"

    expect(book.to_s).to eq "title_1 - author_name_1"
  end
end