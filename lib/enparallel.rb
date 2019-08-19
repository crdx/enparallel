Dir.chdir __dir__ do
    require 'bundler/setup'
    require 'require_all'
    require 'colorize'
    require 'docopt'
end

require_rel 'enparallel'

require 'securerandom'
require 'shellwords'
require 'tempfile'
require 'open3'
require 'etc'

module Enparallel
    class Main
        def self.run(cli)
            tasks = cli.inputs.map { |input| Task.new(cli.command, input) }
            pool = ThreadPool.new(tasks, cli.workers, cli.pick)
            new(pool).run
        end

        def initialize(pool)
            @pool = pool
            @id = 0
        end

        def run
            start

            render_progress do
                @pool.drain_wait
            end

            finish
            save_log
        end

        private

        def start
            puts 'Running %d tasks with %d workers' % [@pool.size, @pool.worker_count]
            puts
        end

        def finish
            puts
            puts "Tasks complete"
            puts
            puts "#{@pool.succeeded_tasks.length.to_s.green.bold} tasks succeeded"
            puts "#{@pool.failed_tasks.length.to_s.red.bold} tasks failed"
            puts
        end

        def render_progress
            thread = Thread.new { loop { render } }
            yield
            thread.terminate
            render
            puts
        end

        def render
            print "\r" + @pool.render
            sleep 0.1
        end

        def all_paths_available(paths)
            paths.all? { |path| !File.exist?(path) }
        end

        def next_id
            @id += 1
        end

        def generate_paths(types)
            loop do
                id = next_id

                paths = types.to_h do |type|
                    [type, '/tmp/enparallel-run-%d-%s.txt' % [id, type]]
                end

                break paths if all_paths_available(paths.values)
            end
        end

        def save_log
            log_groups = @pool.get_log_groups
            types = log_groups.map(&:type).uniq
            paths = generate_paths(types)

            log_groups.each do |log_group|
                type = log_group.type
                path = paths[type]
                puts 'Written %s log: %s (%s)' % [type, *log_group.write(path)]
            end
        end
    end
end
