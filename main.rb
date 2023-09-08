require_relative 'app'
app = App.new

def choices(app)
  puts 'Welcome to App!'
  loop do
    puts 'Please choose an option by enterin a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    num = gets.chomp.to_i
    break if num == 7

    choose_any(app, num)
  end
end

def choose_any(app, num)
  case num
  when 1
    app.list_books
  when 2
    app.list_persons
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.list_rentals
  end
end

choices(app)
