# enparallel

Run many commands enparallel with a colourful overview.

## Usage

 **enparallel** operates by reading lines from standard input, and executing a command once per entry, in parallel.

The placeholder `{}`, if present, is replaced with each line in turn.

```
Usage:
    enparallel [options] <command>

Options:
    -w, --workers N     Batch into a pool of N workers [default: #].
    -p, --pick TYPE     Task-picking rule (see "Types") [default: sequential].
    -v, --version       Version.
    -h, --help          Help.

Types:
    sequential          The order in which the tasks were queued.
    random              Any order.
    outside-in          Start from the edges and work one's way in.
    inside-out          Start from the middle and work one's way out.
```

The default value for `--workers` is what Ruby determines to be the number of CPUs on the current system. The value displayed in the help text is the value that will be used.

## Examples

TODO

## Bugs or contributions

Open an [issue](http://github.com/crdx/enparallel/issues) or send a [pull request](http://github.com/crdx/enparallel/pulls).

## Licence

[MIT](LICENCE.md).
