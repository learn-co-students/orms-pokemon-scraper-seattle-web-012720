require 'pry'


class Pokemon
    attr_reader :id, :name, :type, :db

    def initialize(id:id=nil, name:, type:, db:)
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
        # binding.pry
    end

    def self.find(id, db)
        # binding.pry
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL
        found = db.execute(sql, id).flatten
        # binding.pry
        Pokemon.new(id:found[0], name:found[1], type:found[2], db:db)
        # binding.pry
    end

end
