class Command
    def initialize(name, args)
        @name = name
        @args = args
    end

    def self.from_str(str)
        name, *args = str
        Command.new(name, args)
    end

    def get_line(replacement)
        [@name, *replace(replacement)].shelljoin
    end

    private

    def replace(replacement)
        @args.map { |arg| arg.gsub('{}', replacement) }
    end
end
