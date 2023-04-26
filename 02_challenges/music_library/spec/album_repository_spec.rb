require 'album_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  it "returns a list of albums" do
    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq 2

    expect(albums[0].id).to eq "1"
    expect(albums[0].title).to eq "album_1"
    expect(albums[0].release_year).to eq "2023"
    expect(albums[0].artist_id).to eq "1"

    expect(albums[1].id).to eq "2"
    expect(albums[1].title).to eq "album_2"
    expect(albums[1].release_year).to eq "2021"
    expect(albums[1].artist_id).to eq "2"
  end

  describe "#find" do
    it "returns album where id=1 when passed 1" do
      repo = AlbumRepository.new
      album = repo.find(1)

      expect(album.id).to eq "1"
      expect(album.title).to eq "album_1"
      expect(album.release_year).to eq "2023"
      expect(album.artist_id).to eq "1"
    end

    it "returns album where id=2 when passed 2" do
      repo = AlbumRepository.new
      album = repo.find(2)

      expect(album.id).to eq "2"
      expect(album.title).to eq "album_2"
      expect(album.release_year).to eq "2021"
      expect(album.artist_id).to eq "2"
    end
  end

  describe "#create" do
    it "adds an album record to the database" do
      repo = AlbumRepository.new

      album = Album.new
      album.title = 'Trompe le Monde'
      album.release_year = 1991
      album.artist_id = 5

      repo.create(album)

      all_albums = repo.all
      new_album = all_albums.last
      expect(new_album.title).to eq "Trompe le Monde"
      expect(new_album.release_year).to eq "1991"
      expect(new_album.artist_id).to eq "5"
    end
  end
end