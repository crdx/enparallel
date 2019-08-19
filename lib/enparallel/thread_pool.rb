module Enparallel
    class ThreadPool
        attr_accessor :worker_count

        def initialize(tasks, requested_worker_count, rule)
            @tasks = tasks
            @worker_count = [tasks.length, requested_worker_count].min
            @picker = Picker.new(tasks, rule.to_sym)
        end

        def drain_wait
            drain
            join
        end

        def drain
            @workers = @worker_count.times.map do
                Thread.new do
                    while task = @picker.next
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

        def succeeded_tasks
            @tasks.select(&:has_succeeded?)
        end

        def failed_tasks
            @tasks.reject(&:has_succeeded?)
        end

        def tasks_of(type)
            if type == :success
                succeeded_tasks
            elsif type == :failure
                failed_tasks
            end
        end

        def get_log_groups
            logger.get_log_groups
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
