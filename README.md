# Zig Common Tasks Website

This website was created with [Magnanimous](https://renatoathaydes.github.io/magnanimous/).

All Zig samples are in the [source/processed/samples/](source/processed/samples) directory.

The Zig files are just plain zig files, but include Magnanimous metadata so that they can be included in the main HTML file generated from [source/processed/index.md](source/processed/index.md).

To run the samples' tests:

```bash
zig build test
```

To build the website:

```bash
magnanimous
```

Get Magnanimous by downloading a binary from its [Releases Page](https://github.com/renatoathaydes/magnanimous/releases) or with `go get -u github.com/renatoathaydes/magnanimous` if you have Go installed.
