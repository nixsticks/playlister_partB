require './parser'

class PlayLister
  class << self
    attr_accessor :current_list
  end

  attr_accessor :parser

  def initialize(parser)
    @parser = parser
    @parser.parse
  end

  def run
    puts welcome_message
    loop do
      browse
      puts select_message
      selector
    end
  end

  def self.memoize(list)
    @current_list = list
  end

  private
  def welcome_message
    "Welcome. Browse by artist or genre? (Type exit to exit at any time.)"
  end

  def get_input
    input = gets.chomp.downcase
    exit if input.match(/^e(xit)?$/)
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
    "\nType the name of any artist, song, or genre shown above to go to its page.\nType artist or genre to browse by artist or genre."
  end

  def selector
    choice = get_input

    Artist.index if choice == "artist"
    Genre.index if choice == "genre"

    artist = Artist.search(choice)
    artist.page unless artist.nil?

    song = Song.search(choice)
    song.page unless song.nil?

    genre = Genre.search(choice)
    genre.page unless genre.nil?

    if artist.nil? && song.nil? && genre.nil?
      puts "\nThat choice is not included in the list above. Please try again."
    else
      puts select_message
    end

    selector
  end
end

playlist = PlayLister.new(Parser.new("data"))
playlist.run