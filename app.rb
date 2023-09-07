require_relative 'book'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require_relative 'person'

class App
  attr_accessor :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  # list all books
  def list_books
    puts 'List of books'
    @books.each { |book| puts "title : #{book.title} by author : #{book.author}" }
  end

  def list_persons
    @persons.each do |person|
      if person.instance_of?(Teacher)
        puts "[Teacher]Age: #{person.age} Name: #{person.name}, ID: #{person.id}"
      else
        puts "[Student]Age: #{person.age},Name: #{person.name}, ID: #{person.id} "
      end
    end
  end

  # create person
  def create_person
    print 'Do you want to add a student (1) or a teacher (2)? [Insert the number]: '
    is_student = gets.chomp.strip.to_i
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    person_name = gets.chomp
    case is_student

    when 1
      puts 'Has Parent Permission [Y/N]'
      permission = gets.chomp.downcase == 'y'
      create_student(age, person_name, permission)
    when 2
      create_teacher(age, person_name)
    end
    puts 'Person added successfully'
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
  end

  # create rental
  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    print 'Select a person from the following list by number (not ID)'
    @persons.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name} ID: #{person.id} Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    print 'Enter Rental Date (yyyy-mm-dd)'
    date = gets.chomp
    @rentals.push(Rental.new(date, @books[book_index], @persons[person_index]))
    puts 'Rental added successfully'
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
end
