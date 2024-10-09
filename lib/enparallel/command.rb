module Enparallel
    class Command
        def initialize(name, args)
            @name = name
            @args = args
        end

        def self.from_a(a)
            name, *args = a
            Command.new(name, args)
        end

        def interpolate_safe(replacement)
            [@name, *replace(replacement)].shelljoin
        end

        def interpolate_unsafe(replacement)
            [@name, *replace(replacement)].join(' ')
        end

        private

        def replace(replacement)
            @args.map { _1.gsub('{}', replacement) }
        end
    end
end
