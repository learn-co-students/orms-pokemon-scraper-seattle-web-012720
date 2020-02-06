class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, db:, id:nil)
        @name = name 
        @type = type
        @id = id 
        @db = db
    end

    def self.save(pk_name, pk_type, db)
        sql = <<-SQL
          INSERT INTO pokemon (name, type)
          VALUES (?, ?)
        SQL
     
        db.execute(sql, pk_name, pk_type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
      end

      def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        result = db.execute(sql, id)[0]
        Pokemon.new(id:result[0], name:result[1], type:result[2], db:db)
      end
end
