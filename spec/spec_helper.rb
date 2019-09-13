require 'simplecov'

SimpleCov.start do
    add_filter '/spec/'
    add_filter '/vendor/'
end

def good_command
    Command.from_a(['echo', '{}'])
end

def bad_command
    Command.from_a(['ekko', '{}'])
end

def sleep_command(time)
    Command.from_a(['sleep', time.to_s])
end

def get_task(type, *args)
    Task.new(send(type, *args), 'cheese')
end

def get_pool_of(n, type = :good_command, *args)
    tasks = n.times.map { get_task(type, *args) }
    ThreadPool.new(tasks, Util.processor_count, :sequential)
end

require_relative '../lib/enparallel'
include Enparallel
