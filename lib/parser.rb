require './song'
require './artist'
require './genre'

class Parser
  attr_accessor :artists, :genres, :entries

  MATCH = /(?<artist>.*)\s\-\s(?<song>.*)\s\[(?<genre>.*)\]/

  def initialize(directory)
    @entries = Dir.entries(directory).select {|f| !File.directory? f}
  end

  def parse
    entries.each do |entry|
      match = MATCH.match(entry)

      artist = Artist.search(match[:artist]) || Artist.new.tap {|artist| artist.name = match[:artist]}

      song = Song.new
      song.name = match[:song]
      song.genre = Genre.search(match[:genre]) || Genre.new.tap {|genre| genre.name = match[:genre]}

      artist.add_song(song)
    end
  end
end