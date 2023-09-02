require_relative '../decorators/nameable'

class Person < Nameable
  attr_accessor :name, :age, :id

  def initialize(name: 'Unknown', age: nil, parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    return true if of_age? || parent_permission

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

person = Person.new(22, 'maximilianus')
puts person.correct_name

capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
