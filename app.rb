require './parser'
require 'ruby-debug'

class PlayLister
  attr_reader :parser

  def initialize(parser)
    @parser = parser.run
  end

  def run
    puts browse_message
    browse
  end

  private

  def get_input
    gets.chomp.downcase
  end

  def browse_message
    "Browse by artist or genre"
  end

  def browse
    case get_input
    when "artist"
      print_artists
    when "genre"
      print_genres
    else
      puts "Sorry, I didn't understand you."
      browse
    end
  end

  def print_artists
    Artist::artists.each {|artist| puts "Artist: #{artist.name}, Song Count: #{artist.songs.size}"}
    puts "Total Artists: #{Artist::artists.size}"
    puts "\nSelect Artist"
    print_artist(select_artist)
  end

  def select_artist
    desired_artist = get_input
    Artist::artists.select{|artist| desired_artist == artist.name.downcase}[0]
  end

  def print_artist(artist)
    puts
    puts "#{artist.name} - #{artist.songs.size} Songs"
    artist.songs.each {|song| puts "#{song.name} - #{song.genre.name.capitalize}"}
  end

  def print_genres
    Genre::genres.sort_by {|genre| genre.songs.size}
    Genre::genres.each {|genre| puts "#{genre.name.capitalize} - #{genre.songs.size} Songs, #{genre.artists.size} Artists"}
    puts "\nSelect Genre"
    print_genre(select_genre)
  end

  def select_genre
    desired_genre = get_input
    Genre::genres.select{|genre| desired_genre == genre.name.downcase}[0]
  end

  def print_genre(genre)
    puts "#{genre.name.capitalize}"
    genre.artists.each_with_index do |artist, index|
      print "#{index + 1}. #{artist.name} - "
      artist.songs.each {|song| print "#{song.name}\n"}
    end
  end

  
end

play = PlayLister.new(Parser.new("data"))
play.run
