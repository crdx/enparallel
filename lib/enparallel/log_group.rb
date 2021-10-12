module Enparallel
    class LogGroup
        attr_reader :type
        attr_reader :tasks

        def initialize(type, tasks)
            @type = type
            @tasks = tasks
        end

        def to_soml
            tasks.join("\n\n") + "\n"
        end

        def tasks?
            tasks.length > 0
        end

        def write(path)
            size = File.write(path, to_soml)
            Util.bytes_to_human(size)
        end

        def self.of(type, pool)
            LogGroup.new(type, pool.tasks_of(type))
        end

        def self.success(pool)
            of(:success, pool)
        end

        def self.failure(pool)
            of(:failure, pool)
        end
    end
end
