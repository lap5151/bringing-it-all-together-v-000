class Dog
attr_accessor :id, :name, :breed


  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @breed = hash[:breed]
  end

  def self.create_table
    sql =<<-SQL
    CREATE TABLE IF NOT EXISTS dogs
    SQL

    DB[:conn].execute(sql)
  end


end
