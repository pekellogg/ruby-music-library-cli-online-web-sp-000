require_relative "../lib/concerns/findable.rb"
require_relative "../lib/music_importer.rb"
require_relative "../lib/song.rb"
require_relative "../lib/genre.rb"
require_relative "../lib/artist.rb"
require "pry"

class MusicLibraryController

    attr_accessor :file_path
    include Concerns::Findable
    @@all = []

    def self.all
        @@all
    end

    def save
        @@all << self unless @@all.include?(self)
    end

    def initialize(file_path = "./db/mp3s")
        @file_path = file_path
        music_importer = MusicImporter.new(@file_path)
        music_importer.import
        save
    end

    def call
        input = ""
        while input != "exit"
    
          puts "Welcome to your music library!"
          puts "To list all of your songs, enter 'list songs'."
          puts "To list all of the artists in your library, enter 'list artists'."
          puts "To list all of the genres in your library, enter 'list genres'."
          puts "To list all of the songs by a particular artist, enter 'list artist'."
          puts "To list all of the songs of a particular genre, enter 'list genre'."
          puts "To play a song, enter 'play song'."
          puts "To quit, type 'exit'."
          puts "What would you like to do?"
          input = gets.strip
    
          case input
          when "list songs"
            list_songs
          when "list artists"
            list_artists
          when "list genres"
            list_genres
          when "list artist"
            list_songs_by_artist
          when "list genre"
            list_songs_by_genre
          when "play song"
            play_song
          end
        end
    end

    def list_songs
        sorted = Song.all.sort_by {|s|s.name}
        sorted.each_with_index do |s, i|
            puts "#{i + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        end
    end

    def list_artists
        sorted = Artist.all.sort_by {|a|a.name}
        sorted.each_with_index do |a, i|
            puts "#{i + 1}. #{a.name}"
        end
    end

    def list_genres
        sorted = Genre.all.sort_by {|g|g.name}
        sorted.each_with_index do |g, i|
            puts "#{i + 1}. #{g.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        found_artist = Artist.find_by_name(input)
        if found_artist
            found_artist.songs.sort_by {|s| s.name}.each_with_index {|s, i|puts "#{i + 1}. #{s.name} - #{s.genre.name}"} 
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        found_genre = Genre.find_by_name(input)
        if found_genre
            found_genre.songs.sort_by {|s| s.name}.each_with_index {|s, i|puts "#{i + 1}. #{s.artist.name} - #{s.name}"} 
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        song = Song.all.sort_by(&:name)[input-1]
        valid = input.between?(1, Song.all.count)
        if valid
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end

