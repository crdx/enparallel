module Enparallel
    class Logger
        def self.from_thread_pool(pool)
            Logger.new(pool)
        end

        def initialize(pool)
            @pool = pool
        end

        def get_all_log_groups
            [LogGroup.success(@pool), LogGroup.failure(@pool)]
        end

        def get_log_groups
            get_all_log_groups.select(&:has_tasks?)
        end
    end
end
