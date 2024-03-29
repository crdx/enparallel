set quiet := true

BIN := 'bundle exec ruby -Ilib bin/enparallel'

import? 'internal.just'

[private]
help:
    just --list --unsorted

init:
    bundle install

run +args:
    {{ BIN }} {{ args }}

fmt:
    just --fmt

lint:
    rubocop

fix:
    rubocop -A

test:
    bundle exec rspec
    echo
    echo o coverage/index.html

build:
    bundle exec rake build

install:
    bundle exec rake install

clean:
    rm -vf pkg/*

# build the asciicasts
build-readme:
    internal/build-readme

# run 50 unpredictable tasks
run-50:
    seq 50 | {{ BIN }} --workers 32 --pick random -- internal/unpredictable-task
