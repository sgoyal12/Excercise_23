require 'csv'
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
# This is the class which reads from "data.csv" and writes the data to file "output.txt"
class Files
  def initialize
    @employees = []
  end

  def read_in_csv_data
    CSV.foreach("data.csv", headers: true) do |row|
      @employees << Employee.new(row['Name'], row['EmpId'], row['Designation'])
    end
  end

  def hash_save
  	@employees.inject(Hash.new { |hash, key| hash[key] = [] }) do |hash, element|
  		hash[element.designation].push(element)
  		hash
  	end
  end

  def write_data
  	hash = hash_save.sort.to_h
  	File.open("output.txt", "w") do |file|
      hash.each_key do |key|
      	file.puts hash[key].length > 1 ? "#{key}s" : key
      	file.puts hash[key].sort_by { |employee| employee.emp_id }
      	file.puts ""
      end
    end
  end
end

file = Files.new
file.read_in_csv_data
file.write_data