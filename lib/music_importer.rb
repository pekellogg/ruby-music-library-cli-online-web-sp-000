class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        files = Dir["#{path}/*.mp3"]
        files.each.map do |filepath|
            filepath.sub!("#{path}/","")
        end
    end

    def import
        files.each {|file|Song.create_from_filename(file)}
    end

end
