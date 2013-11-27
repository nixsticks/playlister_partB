require './parser'

class PlayLister
  attr_accessor :parser

  def initialize(parser)
    @parser = parser
    @parser.parse
  end

  def run
    puts welcome_message
    browse
    loop do
      puts select_message
      selector
    end
  end

  private
  def welcome_message
    "Welcome. Browse by artist or genre? (Type exit to exit at any time.)"
  end

  def get_input
    gets.chomp.downcase
  end

  def browse
    case get_input
    when "artist"
      Artist.index
    when "genre"
      Genre.index
    when "exit"
      exit
    else
      puts "Sorry, I didn't understand you."
      browse
    end
  end

  def select_message
    "\nType the name of an artist, song, or genre to go to its page."
  end

  def selector
    choice = get_input

    exit if choice == "exit"

    artist = Artist.search(choice)
    artist.page unless artist.nil?

    song = Song.search(choice)
    song.page unless song.nil?

    genre = Genre.search(choice)
    genre.page unless genre.nil?

    if artist.nil? && song.nil? && genre.nil?
      puts "\nThat choice does not exist in the database. Please try again."
      selector
    end
  end
end

playlist = PlayLister.new(Parser.new("data"))
playlist.run