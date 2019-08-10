class Task
    attr_accessor :stdout
    attr_accessor :stderr

    def initialize(command, input)
        @command = command
        @input = input
        @running = false
        @stdout = ''
        @stderr = ''
        @ran_at = nil
        @exit_status = nil
    end

    def to_s
        status = []

        status << '[command_line]'
        status << command_line

        status << '[exit_status]'
        status << @exit_status

        status << '[ran_at]'
        status << @ran_at

        if not @stdout.empty?
            status << '[stdout]'
            status << @stdout
        end

        if not @stderr.empty?
            status << '[stderr]'
            status << @stderr
        end

        status.join("\n")
    end

    def char
        if @running
            'R'
        elsif @exit_status.nil?
            'S'
        elsif successful?
            'D'.green
        else
            'F'.red
        end
    end

    def run
        @running = true
        @ran_at = Time.now

        Open3.popen3(command_line) do |stdin, stdout, stderr, thread|
            @stdout = stdout.read.chomp
            @stderr = stderr.read.chomp
            @exit_status = thread.value.exitstatus
        end
    rescue => e
        @stderr = e.message
        @exit_status = 1
    ensure
        @running = false
    end

    def successful?
        raise 'Task not resolved' if @ran_at.nil?
        @exit_status == 0
    end

    private

    def command_line
        @command.interpolate(@input)
    end
end
