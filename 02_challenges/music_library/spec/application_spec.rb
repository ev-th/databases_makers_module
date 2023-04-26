require "application"

RSpec.describe Application do

  it "lists all the albums" do
    fake_io = double :fake_io
  
    fake_album_1 = double :fake_album_1, title: "album_1"
    fake_album_2 = double :fake_album_2, title: "album_2"
    fake_albums = [fake_album_1, fake_album_2]
    fake_album_repository = double :fake_album_repository, all: fake_albums
    
    fake_artist_repository = double :fake_artist_repository
  
    app = Application.new(
      "music_library_test",
      fake_io,
      fake_album_repository,
      fake_artist_repository
    )
  
    expect(fake_io).to receive(:puts).with("Welcome to the music library manager!\n")
    expect(fake_io).to receive(:puts).with("What would you like to do?")
    expect(fake_io).to receive(:puts).with("1 - List all albums")
    expect(fake_io).to receive(:puts).with("2 - List all artists\n")
    expect(fake_io).to receive(:print).with("Enter your choice: ")
    expect(fake_io).to receive(:gets).and_return("1\n")
    expect(fake_io).to receive(:puts).with("[ENTER]\n")
    expect(fake_io).to receive(:puts).with("Here is the list of albums:")
    expect(fake_io).to receive(:puts).with(" * 1 - album_1")
    expect(fake_io).to receive(:puts).with(" * 2 - album_2")
  
    app.run
  end

  it "lists all the artists" do

    fake_io = double :fake_io

    fake_album_repository = double :fake_album_repository
    
    fake_artist_1 = double :fake_artist_1, name: "artist_1"
    fake_artist_2 = double :fake_artist_2, name: "artist_2"
    fake_artists = [fake_artist_1, fake_artist_2]
    fake_artist_repository = double :fake_artist_repository, all: fake_artists
    
    app = Application.new(
      "music_library_test",
      fake_io,
      fake_album_repository,
      fake_artist_repository
    )

    expect(fake_io).to receive(:puts).with("Welcome to the music library manager!\n")
    expect(fake_io).to receive(:puts).with("What would you like to do?")
    expect(fake_io).to receive(:puts).with("1 - List all albums")
    expect(fake_io).to receive(:puts).with("2 - List all artists\n")
    expect(fake_io).to receive(:print).with("Enter your choice: ")
    expect(fake_io).to receive(:gets).and_return("2\n")
    expect(fake_io).to receive(:puts).with("[ENTER]\n")
    expect(fake_io).to receive(:puts).with("Here is the list of artists:")
    expect(fake_io).to receive(:puts).with(" * 1 - artist_1")
    expect(fake_io).to receive(:puts).with(" * 2 - artist_2")

    app.run
  end
end