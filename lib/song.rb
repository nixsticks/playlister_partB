require_relative './genre'

class Song
  attr_accessor :name
  attr_reader :genre

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end
end