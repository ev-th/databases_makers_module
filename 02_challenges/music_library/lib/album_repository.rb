require_relative "./album"

class AlbumRepository
  def all
    sql = "SELECT * FROM albums;"

    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      album.artist_id = record["artist_id"]

      albums << album
    end

    albums
  end

  def find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    result_set = DatabaseConnection.exec_params(sql, [id])
    album_record = result_set.first

    album = Album.new
    album.id = album_record["id"]
    album.title = album_record["title"]
    album.release_year = album_record["release_year"]
    album.artist_id = album_record["artist_id"]

    album
  end
end