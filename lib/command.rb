class Command
    def initialize(name, args)
        @name = name
        @args = args
    end

    def get_line(replacement)
        [@name, *replace(replacement)].shelljoin
    end

    private

    def replace(replacement)
        @args.map { |arg| arg.gsub('{}', replacement) }
    end

    def self.from_argv
        name, *args = ARGV
        Command.new(name, args)
    end
end
