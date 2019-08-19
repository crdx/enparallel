module Enparallel
    class ThreadPool
        def initialize(tasks, worker_count, pick_rule)
            @tasks = tasks
            @worker_count = if tasks.length < worker_count then tasks.length else worker_count end
            @picker = Picker.new(tasks, pick_rule.to_sym)
        end

        def drain_wait
            drain
            join
        end

        def drain
            @workers = @worker_count.times.map do
                Thread.new do
                    while task = @picker.pop
                        task.run
                    end
                end
            end
        end

        def size
            @tasks.length
        end

        def render
            @tasks.map(&:char).join.bold
        end

        def successful_tasks
            @tasks.select(&:successful?)
        end

        def failed_tasks
            @tasks.reject(&:successful?)
        end

        def get_logs
            logger.get_logs
        end

        def logger
            @logger ||= Logger.from_thread_pool(self)
        end

        private

        def join
            @workers.each(&:join)
        end
    end
end
