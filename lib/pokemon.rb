class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
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
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
      SQL

      mon = db.execute(sql,id)
      mon_id = mon[0][0]
      mon_name = mon[0][1]
      mon_type = mon[0][2]
      mon_hash = {id: mon_id, name: mon_name, type: mon_type, db: db }
      Pokemon.new(mon_hash)

    end
end

