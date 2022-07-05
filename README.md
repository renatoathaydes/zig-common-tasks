# Zig Common Tasks Website

This repository contains the `Zig Common Tasks` website, which is built with [Magnanimous](https://renatoathaydes.github.io/magnanimous/).

All Zig samples are in the [source/processed/samples/](source/processed/samples) directory.

The Zig files are just plain zig files, but include Magnanimous metadata so that they can be included in the main HTML file generated from [source/processed/index.md](source/processed/index.md).

To run the samples' tests:

```bash
zig build test
```

To build the website:

```bash
magnanimous -style monokai
```

Get Magnanimous by downloading a binary from its [Releases Page](https://github.com/renatoathaydes/magnanimous/releases) or with `go install github.com/renatoathaydes/magnanimous@0.11.1` if you have Go installed.

## Contributing

Contributions are welcome!

Guidelines:

* samples should not be too trivial, but also not complex.
* must only use Zig's standard library.
* must be cross-platform (runs at least on Mac, Windows and Linux).
* preferrably, use tests... `main` also ok if side effects are unavoidable.

All samples are [unlicensed](https://unlicense.org/) and belong to the public domain!

## Project Home

This project's source code is currently hosted on:

* [GitHub](https://github.com/renatoathaydes/zig-common-tasks/)
* [OpenCode](https://www.opencode.net/renatoathaydes/zig-common-tasks/)

Feel free to add to other hosts.
