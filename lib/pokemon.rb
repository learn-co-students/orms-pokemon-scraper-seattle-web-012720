class Pokemon
    attr_accessor :id, :name, :type, :db
    def initialize(id: id=nil,name: name, type: type, db: db)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.new_from_db(row)
        return Pokemon.new(id: row[0], name: row[1], type: row[2])
    end

    def self.save(name, type, db)
        sql = <<-SQL 
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
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
        db.execute(sql, id).map {|row| Pokemon.new_from_db(row)}.first
    end
end
