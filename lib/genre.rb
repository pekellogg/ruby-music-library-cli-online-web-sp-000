require_relative "../lib/concerns/findable.rb"

class Genre
    
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
        @@all << self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        genre = Genre.new(name)
        genre
    end
    
    def songs
        Song.all.select {|song|song.genre == self}
    end

    def artists
        artists = songs.select.map {|song|song.artist}
        artists.uniq
    end
end

