class Pokemon
  attr_accessor :id, :name, :type, :db
  @@all = []

  def initialize(id: nil, name: name, type: type, db: db)
    @id = id
    @name = name
    @type = type
    @db = db
    @@all << self
  end

  def self.new_from_db(row)
    new_pokemon = Pokemon.new(id: row[0], name: row[1], type: row[2])
  end

  def self.save(name, type, db)
    sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?,?)
            SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    self
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon 
    WHERE id = ?
    LIMIT 1
    SQL
    db.execute(sql, id).map do |row|
      Pokemon.new_from_db(row)
    end.first
  end
end
