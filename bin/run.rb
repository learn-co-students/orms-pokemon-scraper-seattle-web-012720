require_relative "environment"
require 'pry'
Scraper.new(@db).scrape

all_pokemon = @db.execute("SELECT * FROM pokemon;")

# test out your code here!

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
binding.pry