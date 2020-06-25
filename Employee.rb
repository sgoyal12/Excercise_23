# This is the employee class to store the data read
class Employee
  attr_reader :name, :emp_id, :designation

  def initialize(name, emp_id, designation)
    @name = name
    @emp_id = emp_id.to_i
    @designation = designation
  end

  def to_s
    "#{@name}(EmpId: #{@emp_id})"
  end
end
