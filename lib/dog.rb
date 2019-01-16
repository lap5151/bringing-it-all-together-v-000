require 'pry'
class Dog
attr_accessor :id, :name, :breed


  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @breed = hash[:breed]
  end

  def self.create_table
    sql =<<-SQL
    CREATE TABLE IF NOT EXISTS dogs(
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql =<<-SQL
    DROP TABLE dogs
    SQL

    DB[:conn].execute(sql)
  end

  def save
    if self.id
      #elf.update
    else
      sql =<<-SQL
      INSERT INTO dogs (name,breed)
      VALUES (?,?)
      SQL

      DB[:conn].execute(sql,self.name,self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end
      self
  end

  def self.create(hash)
    dog = Dog.new(hash)
    dog.save
    dog
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql,id)[0]
    hash = {hash[:id]=>result[0], hash[:name]=>result[1], hash[:breed]=>result[2]}
    dog = Dog.new(hash)
    #dog.id = result[0][0]
    dog
    #binding.pry
  end


end
