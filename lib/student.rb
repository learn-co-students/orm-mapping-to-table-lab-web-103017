require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql =  <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade TEXT
          )
          SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
          Drop table if exists students
          SQL
    DB[:conn].execute(sql)
  end

  def save
    DB[:conn].execute("insert into students (name, grade) values ('#{self.name}', '#{self.grade}')")
    @id = DB[:conn].execute("SELECT id from students where name='#{self.name}'").flatten.join.to_i
  end

  def self.create(name:, grade:)
    @name = name
    @grade = grade
    student = Student.new(@name, @grade)
    student.save
    student
  end


end
