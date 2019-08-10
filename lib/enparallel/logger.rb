class Logger
    def self.from_thread_pool(pool)
        Logger.new(pool)
    end

    def initialize(pool)
        @pool = pool
    end

    def get_logs
        [Log.success(@pool), Log.failure(@pool)].compact
    end
end
