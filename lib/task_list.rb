class TaskList
    include Enumerable

    def initialize(targets, command)
        @tasks = targets.map { |target| Task.new(command, target) }
        @run_id = 1
    end

    def each(&block)
        @tasks.each(&block)
    end

    def length
        @tasks.length
    end

    def start
        puts 'Running %d tasks' % @tasks.length
        puts
    end

    def execute(a = nil)
        # pp a
        # 1. Take a parameter `batch_into` representing how many to batch up by.
        # 2. Divide tasks by `batch_into`, do some maths, then run & join each
        # `batch_into` set of tasks.
        # 3. The render loop will take care of updating the UI.
        each(&:run)
        each(&:join)
    end

    def finish
        puts
        puts "Tasks complete"
        puts
        puts "#{successful_tasks.length.to_s.green.bold} tasks successful"
        puts "#{failed_tasks.length.to_s.red.bold} tasks failed"
        puts
        save
    end

    def render
        map(&:char).join
    end

    private

    def next_logfile_set(*labels)
        loop do
            run_id = next_run_id
            paths = labels.map { |label| '/tmp/enparallel-run-%d-%s.txt' % [run_id, label] }
            return *paths if paths.all? { |path| !File.exist?(path) }
        end
    end

    def next_run_id
        @run_id += 1
    end

    def write_log(logfile, label, tasks)
        return if tasks.length == 0

        file = File.open(logfile, 'w')
        file.write(tasks.join("\n==============================\n") + "\n")
        size = file.size
        file.close

        puts 'Written %s log: %s (%s)' % [label, file.path, Util.bytes_to_human(size)]
    end

    def save
        success_logfile, failure_logfile = next_logfile_set('success', 'failure')
        write_log(success_logfile, 'success', successful_tasks)
        write_log(failure_logfile, 'failure', failed_tasks)
    end

    def successful_tasks
        @tasks.select(&:successful?)
    end

    def failed_tasks
        @tasks.reject(&:successful?)
    end
end
