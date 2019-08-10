class TaskList
    include Enumerable

    def initialize(targets, command, pick)
        @tasks = targets.map { |target| Task.new(command, target) }
        @pick = pick
    end

    def each
        @tasks.each
    end

    def length
        @tasks.length
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
