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
            puts 'Running %d tasks' % @pool.size
            puts
        end

        def finish
            puts
            puts "Tasks complete"
            puts
            puts "#{@pool.successful_tasks.length.to_s.green.bold} tasks successful"
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

        def get_paths
        end

        def save_log
            logs = @pool.get_logs
            pp logs
        end
    end
end
