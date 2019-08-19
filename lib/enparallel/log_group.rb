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

        def has_tasks?
            tasks.length > 0
        end

        def write(path)
            lf = "\n"
            size = File.write(path, @tasks.join(lf + '=' * 30 + lf) + lf)
            [path, Util.bytes_to_human(size)]
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
