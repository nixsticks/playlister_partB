require 'ruby-debug'
require 'awesome_print'
require './lib/song.rb'
require './lib/artist.rb'
require './lib/genre.rb'

class Parser
  attr_accessor :artists, :genres, :entries

  MATCH = /(.*)\s\-\s(.*)\s\[(.*)\]/

  def initialize(directory)
    @entries = Dir.entries(directory).select {|f| !File.directory? f}
  end

  def get_genres
    entries.each do |entry|
      match = MATCH.match(entry)
      Genre.new.tap{|g| g.name = match[3]}
    end
    Genre::genres.uniq! {|genre| genre.name}
  end

  def get_songs
    songs = []
    entries.each do |entry|
      match = MATCH.match(entry)
      Genre::genres.each do |genre|
        if genre.name == match[3]
          song = Song.new
          song.name = match[2]
          song.genre = genre
          songs << song
          next
        end
      end
    end
    songs
  end

  def get_artists
    entries.each do |entry|
      match = MATCH.match(entry)
      Artist.new.tap{|a| a.name = match[1]}
    end
    Artist::artists.uniq! {|artist| artist.name}
  end

  def run
    get_genres
    get_artists
    songs = get_songs

    entries.each do |entry|
      match = MATCH.match(entry)
      songs.each do |song|
        Artist::artists.map do |artist|
          artist.add_song(song) if song.name == match[2] && artist.name == match[1]
        end
      end
    end
    artists
  end
end

# parser = Parser.new("/Users/nthean/Development/Projects/Flatiron/playlister_partB/data")
# parser.get_genres
# p parser.get_songs.size