class Task
    def initialize(command, target)
        @command = command
        @target = target
    end

    def join
        @thread.join
    end

    def char
        return '?'
        # case @thread.status
        #     when 'run'      then 'R'
        #     when 'aborting' then 'A'.red
        #     # when 'sleep'    then 'S'.light_black.on_white
        #     when nil        then 'E' # exception
        #     when false      then char_for_exit_status
        #     else                 'R'
        # end.bold
    end

    def run
        @run_date = Time.now
        Open3.popen3(line) do |stdin, stdout, stderr, thread|
            @value = thread.value
            @stdout = stdout.read.chomp
            @stderr = stderr.read.chomp
        end
    end

    def successful?
        exit_status == 0
    end

    def to_s
        status = [
            "[cmd]\n#{line}",
            "[exit_status]\n#{exit_status}",
            "[run_date]\n#{@run_date}",
        ]

        if @stdout.length > 0
            status << "[stdout]\n#{@stdout}"
        end

        if @stderr.length > 0
            status << "[stderr]\n#{@stderr}"
        end

        status.join("\n")
    end

    private

    def char_for_exit_status
        if successful?
            'D'.green
        else
            'F'.red
        end
    end

    def line
        @command.get_line(@target)
    end

    def exit_status
        @value.exitstatus
    end
end
