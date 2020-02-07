require 'pry'


class Pokemon
    # attr_accessor :name, :type
    attr_reader :id, :name, :type, :db

    # def initialize (hash)
    #     binding.pry
    #     @id = hash[:id]
    #     @name = hash[:name]
    #     @type = hash[:type]
    #     @db = hash[:db]
    # end

    def initialize (id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
        
        # SQLRunner.execute_schema_migration_sql
        # binding.pry
    end

    def self.save (name, type, db)
        # binding.pry
        sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find (id, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ?
            SQL
        # binding.pry
        poke = db.execute(sql, id).flatten
        # pp poke
        # binding.pry
        Pokemon.new(id:poke[0],name:poke[1],type:poke[2], db:db)
        # binding.pry
        # new_poke

    end
end
