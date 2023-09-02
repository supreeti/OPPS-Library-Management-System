require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  attr_accessor :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def list_books
    puts 'Book list'
    @books.each { |book| puts "title : #{book.title} by author : #{book.author}" }
  end

  def list_persons
    @persons.each do |person|
      if person.instance_of?(Student)
        puts "[Student]Age: #{person.age}, Name: #{person.name}, ID: #{person.id} "
      else
        puts "[Teacher]Age: #{person.age}, Name: #{person.name}, ID: #{person.id}"
      end
    end
  end

  def create_person
    print 'Do you want to add a 1)student or 2)teacher? [Insert 1 or 2]: '
    is_student = gets.chomp.strip.to_i
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    case is_student

    when 1
      puts 'Has Parent Permission [Y/N]'
      permission = gets.chomp.downcase == 'y'
      create_student(age, name, permission)
    when 2
      create_teacher(age, name)
    end
    puts 'Person added successfully'
    $stdout.flush
  end

  def create_student(age, person, permission)
    persons << Student.new(age, person, parent_permission: permission)
  end

  def create_teacher(age, person)
    puts 'Specialization'
    specialization = gets.chomp
    @persons << Teacher.new(age, specialization, person)
  end

  # create book
  def create_book
    print 'Title: '
    book_title = gets.chomp
    print 'Author: '
    book_author = gets.chomp
    @books << Book.new(book_title, book_author)
    puts 'Book added successfully'
    $stdout.flush
  end

  # create rental
  def create_a_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    select_book = @books[book_index]
    print 'Select a person from the following list by number (not ID)'
    @persons.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name} ID: #{person.id} Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    select_person = @persons[person_index]
    print 'Enter Rental Date (yyyy-mm-dd)'
    date = gets.chomp
    @rentals.push(Rental.new(date, select_book, select_person))
    puts 'rental added successfully'
    $stdout.flush
  end

  # list_all_rentals
  def list_rentals
    print 'ID of person'
    input_person_id = gets.chomp.to_i
    puts 'Rentals'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title}" if rental.person.id == input_person_id
    end
  end

  def choices
    puts 'Please Choose an Option by entering a number:'
    puts '1. List all books.'
    puts '2. List all people.'
    puts '3. Create a person.'
    puts '4. Create a book.'
    puts '5. Create a rental.'
    puts '6. List all rentals for a given person id.'
    puts '7. EXIT'
  end

  def choose_any(choice)
    case choice
    when 1
      list_books
    when 2
      list_persons
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    end
  end

  def show
    loop do
      choices
      choice = gets.chomp.to_i
      if choice >= 7
        puts 'Thank you for using this app'
        break
      end
      choose_any(choice)
    end
  end
end
