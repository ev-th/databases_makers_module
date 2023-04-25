class Book
  attr_accessor :id, :title, :author_name

  def to_s
    "#{@title} - #{@author_name}"
  end
end