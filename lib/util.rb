class Util
    def self.bytes_to_human(size)
        if size > 1024
            (size / 1024).to_s + 'K'
        else
            size.to_s + 'B'
        end
    end
end
