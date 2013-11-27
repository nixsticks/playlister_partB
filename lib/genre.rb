require_relative "./searchable"

class Genre
  extend Searchable

  attr_accessor :name, :songs, :artists

  class << self
    attr_accessor :genres
  end

  @genres = []

  def initialize
    @songs = []
    @artists = []
    Genre::genres << self
  end
  
  def page
    puts "\n#{name.capitalize}: #{artists.size} Artists, #{songs.size} Songs\n\n"
    artists.each do |artist|
      print "#{artist.name}: "
      artist.songs.each {|song| puts "#{song.name}" if song.genre == self}
    end
  end

  def self.all
    genres
  end

  def self.reset_genres
    genres.clear
  end

  def self.index
    puts
    all_genres = genres.sort_by {|genre| genre.songs.size}
    genres.each do |genre|
      puts "#{genre.name.capitalize}: #{genre.songs.size} Songs, #{genre.artists.size} Artists"
    end
    puts
  end
end