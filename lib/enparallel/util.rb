module Enparallel
    class Util
        def self.processor_count
            Etc.nprocessors
        end

        def self.dedent(str)
            indentation_level = str.lines.map { |line| line[/^\s*/].length }.min
            return str if indentation_level == 0
            return str.lines.map { |line| line[indentation_level..-1] }.join
        end

        def self.indent(str, level: 4)
            str.lines.map { |line| ' ' * level + line }.join
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
