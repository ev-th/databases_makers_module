class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts("Welcome to the music library manager!\n")
    @io.puts("What would you like to do?")
    @io.puts("1 - List all albums")
    @io.puts("2 - List all artists\n")
    @io.print("Enter your choice: ")
    choice = @io.gets.chomp
    @io.puts("[ENTER]\n")

    case choice
    when "1"
      print_albums(@album_repository.all)
    when "2"
      print_artists(@artist_repository.all)
    end
  end

  private

  def print_albums(albums)
    @io.puts "Here is the list of albums:"
    albums.each_with_index { |album, i| @io.puts " * #{i + 1} - #{album.title}"}
  end

  def print_artists(artists)
    @io.puts "Here is the list of artists:"
    artists.each_with_index { |artist, i| @io.puts " * #{i + 1} - #{artist.name}"}
  end
end