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
end