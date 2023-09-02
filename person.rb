require './decorators/nameable'
require_relative 'rental'
require './decorators/trim'
require './decorators/capitalize_decorator'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id
  attr_writer :parent_permission

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    return true if of_age? || @parent_permission

    false
  end

  def of_age?
    return true if @age >= 18

    false
  end
  private :of_age?
end

def correct_name
  name
end

def add_rental(book, date)
  Rental.new(date, book, self)
end

person = Person.new(22, 'maximilianus')
puts person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
