require './song'
require './artist'
require './genre'

class Database
  attr_accessor :files

  MATCH = /(?<artist>.*)\s\-\s(?<song>.*)\s\[(?<genre>.*)\]/

  def initialize(directory)
    @files = Dir.entries(directory).select {|f| !File.directory? f}
  end

  def parse
    files.each do |file|
      match = MATCH.match(file)

      artist = Artist.search(match[:artist]) || Artist.new.tap {|artist| artist.name = match[:artist]}

      song = Song.new.tap {|song| song.name = match[:song]}
      song.genre = Genre.search(match[:genre]) || Genre.new.tap {|genre| genre.name = match[:genre]}

      artist.add_song(song)
    end
  end
end