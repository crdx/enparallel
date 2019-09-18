# enparallel

Run many commands enparallel with a colourful overview.

## Installation

Install from [rubygems.org](https://rubygems.org/gems/enparallel-bin).

```
gem install enparallel-bin
```

The binary is called `enparallel`.

## Usage

 Standard operation is to read lines from standard input, and execute a command once per entry, in parallel.

The placeholder `{}`, if present, is replaced with each entry in turn.

```
seq 1 10 | enparallel sleep {}
```

To run a more complex command or to make use of shell functions or constructs
(the argument is run as a program) use a call to `bash -c`. Note that
because of the `-c` you need to prefix the command with `--` to indicate the
end of parameters to enparallel.

```
seq 1 10 | enparallel -- bash -c "sleep {} && echo Slept for {}"
```

## Examples

With `--pick sequential`, tasks are picked from the list in order.

![](examples/sequential.gif)

With `--pick random`, tasks are picked from the list in a random order.

![](examples/random.gif)

## Command line interface

```
Usage:
    enparallel [options] [--] <command>...

Description:
    enparallel operates by reading lines from standard input, and executing
    <command> once per entry, in parallel.

Options:
    -w, --workers <n>   Batch into a pool of <n> workers [default: #].
    -p, --pick <type>   Task-picking rule (see "Types") [default: sequential].
    -v, --version       Version.
    -h, --help          Help.

Types:
    sequential          The order in which the tasks were queued.
    random              Random order.
```

The default value for `--workers` is what Ruby determines to be the number of CPUs on the current system. The value displayed in the help text is the value that will be used.

## Tests

Run tests with `tools/test`.

Code coverage is output to `coverage/`, and stands at 100% for library code.

## Development

Use `tools/install` to build and install locally for testing.

Use `tools/publish` to release to rubygems.org

## Log output

Task logs are written out in SOML.

See [SOML](https://github.com/crdx/soml) for more details.

## Bugs or contributions

Open an [issue](http://github.com/crdx/enparallel/issues) or send a [pull request](http://github.com/crdx/enparallel/pulls).

## Licence

[MIT](LICENCE.md).
