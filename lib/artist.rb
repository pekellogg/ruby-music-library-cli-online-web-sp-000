require_relative "../lib/concerns/findable.rb"
class Artist

    extend Concerns::Findable
    attr_accessor :name

    @@all = []

    def self.all
        @@all
    end

    def initialize(name)
        @name = name
        save
    end

    def save
        @@all << self unless @@all.include?(self)
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        artist = Artist.new(name)
        artist
    end

    def songs
        Song.all.select {|song|song.artist == self}
    end
    
    def add_song(song)
        song.artist = self unless song.artist
    end

    def genres
        genres = songs.select.map {|song|song.genre}
        genres.uniq
    end

end