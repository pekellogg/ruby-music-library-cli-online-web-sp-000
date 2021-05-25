class Song

    attr_reader :artist
    attr_accessor :name, :genre

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    @@all = []

    def self.all
        @@all
    end

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        save
    end

    def save
        @@all << self unless @@all.include?(self)
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song
    end

    def self.find_by_name(name)
        Song.all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(file)
        files_array = file.split(" - ")
        song = Song.new(files_array[1])
        song.artist = Artist.find_or_create_by_name(files_array[0])
        song.genre = Genre.find_or_create_by_name(files_array[2].sub(".mp3",""))
        song
    end

    def self.create_from_filename(file)
        new_from_filename(file)
    end

end