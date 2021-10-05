module Enparallel
    class CLI
        def initialize(opts, stdin)
            @opts = opts
            @stdin = stdin
        end

        def self.workers_default
            Util.processor_count
        end

        def self.pick_default
            'sequential'
        end

        def self.parse(argv, stdin)
            opts = Docopt::docopt(usage, argv: argv)

            if opts['--version']
                puts VERSION
                exit
            end

            new(opts, stdin)
        end

        def self.basename
            File.basename($0)
        end

        def self.usage
            <<~EOF
                Usage:
                    #{basename} [options] [--] <command>...
                    #{basename} ( --version | --help )

                Description:
                    #{basename} operates by reading lines from standard input, and executing
                    <command> once per entry, in parallel.

                    The placeholder "{}", if present, is replaced with each line of input in turn.

                    seq 1 10 | enparallel sleep {}

                    To run a more complex command or to make use of shell functions or constructs
                    (enparallel runs its argument as a program) use a call to "bash -c". Note that
                    because of the "-c" you need to prefix the command with "--" to indicate the
                    end of parameters to enparallel.

                    seq 1 10 | enparallel -- bash -c "sleep {} && echo Slept for {}"

                Options:
                    -w, --workers <n>   Batch into a pool of <n> workers [default: #{workers_default}].
                    -p, --pick <type>   Task-picking rule (see "Types") [default: #{pick_default}].
                    -v, --version       Version.
                    -h, --help          Help.

                Types:
                    sequential          The order in which the tasks were queued.
                    random              Random order.
            EOF
        end

        def inputs
            @inputs ||= @stdin.each_line.map(&:chomp)
        end

        def command
            Command.from_a(@opts['<command>'])
        end

        def workers
            @opts['--workers'].to_i || workers_default
        end

        def pick
            @opts['--pick'] || pick_default
        end
    end
end
