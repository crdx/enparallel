module Enparallel
    class Util
        def self.processor_count
            Etc.nprocessors
        end

        def self.bytes_to_human(size)
            if size >= 1024
                '%sK' % (size / 1024)
            else
                '%sB' % size
            end
        end
    end
end
