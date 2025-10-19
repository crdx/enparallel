require 'colorize'
require 'docopt'
require 'soml'

require 'securerandom'
require 'shellwords'
require 'tempfile'
require 'open3'
require 'etc'

module Enparallel
    def self.root_dir
        File.expand_path('..', __dir__)
    end
end

require_relative 'enparallel/cli'
require_relative 'enparallel/command'
require_relative 'enparallel/log_group'
require_relative 'enparallel/logger'
require_relative 'enparallel/picker'
require_relative 'enparallel/task'
require_relative 'enparallel/thread_pool'
require_relative 'enparallel/util'
require_relative 'enparallel/version'
