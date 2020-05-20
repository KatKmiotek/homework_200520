require('pry')
require_relative('../db/sql_runner')

class Artist

attr_reader :id, :name

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
end


def save()
  sql = "INSERT INTO artists(name) VALUES ($1) RETURNING id"
  values = [@name]
  returned_array = SqlRunner.run(sql, values)
  @id = returned_array[0]['id'].to_i
end

def Artist.delete_all()
  sql = "DELETE FROM artists"
  SqlRunner.run(sql)
end

def Artist.all()
  sql = "SELECT * FROM artists"
  artists = SqlRunner.run(sql)
  return artists.map { |artist| Artist.new(artist) }
end

def find_all_albums()
  sql = "SELECT * FROM albums WHERE artist_id = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  albums = result.map { |album| Album.new(album) }
  return albums
end

def find_by_id(id)
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [id]
  result = SqlRunner.run(sql, values)
  return result.map { |artist| Artist.new(artist)  }
end

def update()
  sql = "UPDATE artists SET name = $1 WHERE id = $2"
  values = [@name, @id]
  SqlRunner.run(sql, values)
end

end
