module Enparallel
    class Task
        attr_accessor :stdout
        attr_accessor :stderr

        def initialize(command, input, ascii)
            @command = command
            @input = input
            @running = false
            @stdout = ''
            @stderr = ''
            @ran_at = nil
            @exit_status = nil
            @ascii = ascii
        end

        def to_s
            document = SOML::Document.new

            document.add('CommandLine', command_line_unsafe)
            document.add('ExitStatus', @exit_status)
            document.add('RanAt', @ran_at)
            document.add('StandardOutput', @stdout) unless @stdout.empty?
            document.add('StandardError', @stderr) unless @stderr.empty?

            document.to_s
        end

        def char
            if @running
                @ascii ? 'R' : '😼'
            elsif @exit_status.nil?
                @ascii ? 'S' : '😴'
            elsif has_succeeded?
                (@ascii ? 'D' : '✓')
            else
                (@ascii ? 'F' : '╳')
            end
        end

        def run
            @running = true
            @ran_at = Time.now

            Open3.popen3(command_line_safe) do |stdin, stdout, stderr, thread|
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

        def has_succeeded?
            raise 'Task not resolved' if @ran_at.nil?
            @exit_status == 0
        end

        private

        def command_line_safe
            @command.interpolate_safe(@input)
        end

        def command_line_unsafe
            @command.interpolate_unsafe(@input)
        end
    end
end
