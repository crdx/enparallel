module Enparallel
    class LogGroup
        attr_reader :type, :tasks

        def initialize(type, tasks)
            @type = type
            @tasks = tasks
        end

        def content
            tasks.join("\n%s\n" % '=' * 30) + "\n"
        end

        def self.success(pool)
            if pool.successful_tasks.length > 0
                LogGroup.new(:success, pool.successful_tasks)
            end
        end

        def self.failure(pool)
            if pool.failed_tasks.length > 0
                LogGroup.new(:failure, pool.failed_tasks)
            end
        end
    end
end
