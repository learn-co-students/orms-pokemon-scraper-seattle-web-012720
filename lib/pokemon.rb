class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id: id = nil, name: name, type: type, db: db)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
  INSERT INTO pokemon (name, type)
  VALUES (?, ?)
SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    dog = Dog.new(name, breed)
    dog.save
    dog
  end

  def self.new_from_db(row)
    x = self.new
    x.id = row[0]
    x.name = row[1]
    x.type = row[2]
    x
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id = ?
    SQL

    db.execute(sql, id).map do |row|
      self.new_from_db(row)
    end.first
  end
end
