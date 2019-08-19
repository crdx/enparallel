Dir.chdir __dir__ do
    require 'bundler/setup'
    require 'require_all'
    require 'colorize'
    require 'docopt'
end

require_rel 'enparallel'

require 'securerandom'
require 'shellwords'
require 'tempfile'
require 'open3'
require 'etc'
