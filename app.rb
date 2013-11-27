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
    puts select_message
    selector
  end

  private
  def welcome_message
    "Welcome. Browse by artist or genre? (Type exit to exit at any time.)"
  end

  def get_input
    input = gets.chomp.downcase
    exit if input == "exit"
    input
  end

  def browse
    case get_input
    when "artist"
      Artist.index
    when "genre"
      Genre.index
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

    artist = Artist.search(choice)
    artist.page unless artist.nil?

    song = Song.search(choice)
    song.page unless song.nil?

    genre = Genre.search(choice)
    genre.page unless genre.nil?

    if artist.nil? && song.nil? && genre.nil?
      puts "\nThat choice does not exist in the database. Please try again."
    else
      puts select_message
    end
    selector
  end
end

playlist = PlayLister.new(Parser.new("data"))
playlist.run