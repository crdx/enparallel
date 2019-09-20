require 'require_all'
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
        File.expand_path('../..', __FILE__)
    end
end

require_rel 'enparallel'
