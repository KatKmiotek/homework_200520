require('pry')
require_relative('../db/sql_runner')
class Album

  attr_accessor :id, :title, :year, :artist_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @year = options['year'].to_i
  @artist_id = options['artist_id'].to_i
end


def save()
sql = "INSERT INTO albums(title, year, artist_id) VALUES ($1, $2, $3) RETURNING id"
values = [@title, @year, @artist_id]
returned_array = SqlRunner.run(sql, values)
@id = returned_array[0]['id'].to_i
end

def Album.all()
  sql = "SELECT * FROM albums"
  albums = SqlRunner.run(sql)
  return albums.map { |album| Album.new(album) }
end


def Album.delete_all()
  sql = "DELETE FROM albums"
  SqlRunner.run(sql)
end

def find_artist()
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [@artist_id]
  result = SqlRunner.run(sql, values)
  return Artist.new(result[0])
end

def find_by_id(id)
  sql = "SELECT * FROM albums WHERE id = $1"
  values = [id]
  result = SqlRunner.run(sql, values)
  return result.map { |album| Album.new(album)  }
end

def update()
  sql = "UPDATE albums SET (title, year, artist_id) = ($1, $2, $3) WHERE id = $4"
  values = [@title, @year, @artist_id, @id]
  SqlRunner.run(sql, values)
end

end
