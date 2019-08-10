class CLI
    def initialize(opts)
        @opts = opts
    end

    def self.workers_default
        Util.processor_count
    end

    def self.pick_default
        'sequential'
    end

    def self.parse(argv)
        new(Docopt::docopt(usage, argv: argv))
    rescue Docopt::Exit => e
        puts e.message
        exit 1
    end

    def self.basename
        File.basename($0)
    end

    def self.usage
        <<~EOF
            #{'Usage:'.bold}
                #{basename} [options] <command>

            #{'Description:'.bold}
                #{basename} operates by reading lines from standard input, and executing
                <command> once per entry, in parallel.

                The placeholder "{}", if present, is replaced with each line in turn.

            #{'Options:'.bold}
                -w, --workers N     Batch into a pool of N workers [default: #{workers_default}].
                -p, --pick TYPE     Task-picking rule (see "Types") [default: #{pick_default}].
                -v, --version       Version.
                -h, --help          Help.

            #{'Types:'.bold}
                sequential          The order in which the tasks were queued.
                random              Any order.
                outside-in          Start from the edges and work one's way in.
                inside-out          Start from the middle and work one's way out.
        EOF
    end

    def targets
        @stdin ||= STDIN.each_line.map(&:chomp)
    end

    def command
        Command.from_str(@opts['<command>'])
    end

    def workers
        @opts['--workers'].to_i || workers_default
    end

    def pick
        @opts['--pick'] || pick_default
    end
end
