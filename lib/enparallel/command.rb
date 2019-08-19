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

        def interpolate(replacement)
            [@name, *replace(replacement)].shelljoin
        end

        private

        def replace(replacement)
            @args.map { |arg| arg.gsub('{}', replacement) }
        end
    end
end
