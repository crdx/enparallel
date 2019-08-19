module Enparallel
    class Logger
        def self.from_thread_pool(pool)
            Logger.new(pool)
        end

        def initialize(pool)
            @pool = pool
        end

        def get_logs
            [LogGroup.success(@pool), LogGroup.failure(@pool)].compact
        end
    end
end
