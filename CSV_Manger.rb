require 'csv'
require_relative 'Employee'
# This is the class which reads from "data.csv" and writes the data to file "output.txt"
class CsvManager
  def initialize
    @employees = []
  end

  def read(file_name)
    CSV.foreach(file_name, headers: true) do |row|
      @employees << Employee.new(row['Name'], row['EmpId'], row['Designation'])
    end
  end

  def convert_hash
    @employees.inject(Hash.new { |hash, key| hash[key] = [] }) do |hash, element|
      hash[element.designation].push(element)
      hash
    end
  end

  def export_text(file_name)
    hash = convert_hash.sort.to_h
    File.open(file_name, "w") do |file|
      hash.each_key do |key|
        file.puts hash[key].length > 1 ? "#{key}s" : key
        file.puts hash[key].sort_by { |employee| employee.emp_id }
        file.puts
      end
    end
  end
end

reader_writer = CsvManager.new
reader_writer.read('data.csv')
reader_writer.export_text('output.txt')