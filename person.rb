require_relative '../decorators/nameable'

class Person < Nameable
  attr_accessor :name, :age, id

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
