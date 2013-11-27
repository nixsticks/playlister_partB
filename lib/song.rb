require_relative './genre'
require_relative './searchable'

class Song
  extend Searchable
  attr_accessor :name, :artist
  attr_reader :genre

  class << self
    attr_accessor :songs
  end

  @songs = []

  def initialize
    Song::songs << self
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end

  def page
    puts "\n#{name}"
    puts "Artist: #{artist.name}"
    puts "Genre: #{genre.name.capitalize}"
  end

  def self.all
    songs
  end
end