require_relative 'rental'
class Book
  attr_accessor :author, :title, :rentals

  def initialize(title, author)
    @author = author
    @title = title
    @rentals = []
  end

  def add_rental(person, date)
    Rental.new(date, person, self)
  end
end
