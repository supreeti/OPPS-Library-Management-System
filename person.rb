class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name: 'unknown', parent_permission: true)
    @id = 0
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
