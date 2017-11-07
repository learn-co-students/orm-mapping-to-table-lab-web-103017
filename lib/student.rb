class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
      DB[:conn].execute(sql) #create a table
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade) #that above (?,?) protects you from malicious dofmoiwmfeopw[q3]
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    # self#
  end

  def self.create(name:, grade:) #class method, create row to insert into table
    new_row = self.new(name, grade)
    new_row.save #calling the save method, i created.
    new_row
  end
  #
  # def self.all
  #   station_rows = DB[:conn].execute("SELECT * FROM stations") #every row in table
  #   stations_rows.collect { |row| puts row}
  # end
end
