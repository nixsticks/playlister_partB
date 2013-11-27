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
    PlayLister.memoize(artists)
    artists.each_with_index do |artist, i|
      print "#{i+1}. #{artist.name}: "
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
    sorted_genres = genres.sort_by {|genre| genre.songs.size}
    PlayLister.memoize(sorted_genres)
    sorted_genres.each do |genre|
      puts "#{genre.name.capitalize}: #{genre.songs.size} Songs, #{genre.artists.size} Artists"
    end
  end
end