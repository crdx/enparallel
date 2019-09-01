# enparallel

Run many commands enparallel with a colourful overview.

## Installation

The gem is called `enpara` because rubygems.org decided that `enparallel` is too close to `parallel`, a _typo-protected_ gem.

```
gem install enpara
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

SOML is a simple output format intended to be readable but parseable. The primary goal is to keep long multiline strings readable when displayed next to simple values. A familiar heredoc-like syntax delimits the lengthy output.

### `SOML::Document`

A document is represented by a set of fields. Fields are separated with no more than one newline. Two new lines delimit multiple documents.

### `SOML::Field`

A field is represented by name and a value. A value can be a single line value or a value that spans multiple lines.

## Bugs or contributions

Open an [issue](http://github.com/crdx/enparallel/issues) or send a [pull request](http://github.com/crdx/enparallel/pulls).

## Licence

[MIT](LICENCE.md).
