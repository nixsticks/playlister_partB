require 'ruby-debug'

class Artist
  attr_accessor :name, :songs

  @artists = []

  class << self
    attr_accessor :artists
  end

  def initialize
    @songs = []
    Artist::artists << self
  end

  def add_song(song)
    songs << song
    song.genre.artists << self if song.genre && song.genre.artists.include?(self) == false
  end

  def genres
    songs.map {|song| song.genre}
  end

  def songs_count
    songs.size
  end

  def self.count
    artists.size
  end

  def self.all
    artists
  end

  def self.reset_artists
    artists.clear
  end
end