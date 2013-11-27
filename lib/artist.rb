require_relative "./searchable"

class Artist
  extend Searchable

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
    song.artist = self
  end

  def genres
    songs.map {|song| song.genre}
  end

  def songs_count
    songs.size
  end

  def page
    puts "\n#{name} - #{songs.size} Songs"
    PlayLister.memoize(songs)
    songs.each_with_index {|song, i| puts "#{i+1}. #{song.name} (#{song.genre.name})"}
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

  def self.index
    puts
    PlayLister.memoize(artists)
    artists.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name} - #{artist.songs.size} Songs"
    end
    puts "\nTotal: #{artists.size} Artists"
  end
end