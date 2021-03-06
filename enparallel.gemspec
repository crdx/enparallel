require_relative 'lib/enparallel/version'

Gem::Specification.new do |spec|
    spec.homepage = 'https://github.com/crdx/enparallel'
    spec.summary  = 'Run many commands enparallel with a colourful overview'
    spec.name     = 'enparallel-bin'
    spec.version  = Enparallel::VERSION
    spec.author   = 'crdx'
    spec.license  = 'MIT'

    spec.files    = Dir['{lib}/**/*']
    spec.executables = ['enparallel']

    spec.add_runtime_dependency 'require_all', '~> 2.0'
    spec.add_runtime_dependency 'colorize',    '~> 0.8.1'
    spec.add_runtime_dependency 'docopt',      '~> 0.6.1'
    spec.add_runtime_dependency 'soml',        '~> 1.0.1'

    spec.add_development_dependency 'simplecov', '~> 0.17.0'
    spec.add_development_dependency 'rspec',     '~> 3.8'
    spec.add_development_dependency 'rake',      '~> 12.3'
end
