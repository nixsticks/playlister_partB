require 'ruby-debug'
require 'awesome_print'
require './lib/song'
require './lib/artist'
require './lib/genre'

class Parser
  attr_accessor :artists, :genres, :entries

  MATCH = /(.*)\s\-\s(.*)\s\[(.*)\]/

  def initialize(directory)
    @entries = Dir.entries(directory).select {|f| !File.directory? f}
  end

  def parse
    entries.each do |entry|
      match = MATCH.match(entry)

      artist = Artist.search(match[1]) || Artist.new.tap {|artist| artist.name = match[1]}

      song = Song.new
      song.name = match[2]
      song.genre = Genre.search(match[3]) || Genre.new.tap {|genre| genre.name = match[3]}

      artist.add_song(song)
    end
  end
end