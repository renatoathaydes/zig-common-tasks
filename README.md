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

### Committing a new version of the website

To allow switching between Zig versions, each version of the website needs to be committed into source control.

To do that, run the following commands, approximately:

```shell
# add the new version to the HTML
gedit source/processed/fragments/_header.html
# commit pending changes
git commit -am "..."
# this will delete all previous versions
rm -rf target
# build again
magnanimous -style monokai
# move the target folder to a temp versioned folder
mv target target-0.xx
# restore the previous versions
git reset --hard
# move the temp versioned folder to its expected location
mv target-0.xx target/0.xx
# ensure that gitignore does not ignore the new directory
gedit .gitignore
# add the new version to the older HTML files (zversion's select tag)
gedit target/0.xx/index.html
# done, commit, tag and push everything
git commit -am "..."
git tag 0.xx
git push --all
```

## Contributing

Contributions are welcome!

Guidelines:

* samples should not be too trivial, but also not complex.
* must only use Zig's standard library.
* should be cross-platform (runs at least on Mac, Windows and Linux).
* preferrably, use tests... `main` also ok if side effects are unavoidable (like printing something).

All samples are [unlicensed](https://unlicense.org/) and belong to the public domain!

Procedure:

* make sure you're using the Zig version declared in [test.yml](.github/workflows/test.yml) (if it's old, feel free to update it!).
* add your sample file in `source/processed/samples/`. Start by copying one of the existing ones.
* ensure the metadata (`name`, `id`) is correct.
* run `zig fmt source/processed/samples/`.
* run `zig build test`.
* Make a merge request on OpenCode or GitHub.

## Project Home

This project's source code is currently hosted on:

* [GitHub](https://github.com/renatoathaydes/zig-common-tasks/)
* [OpenCode](https://www.opencode.net/renatoathaydes/zig-common-tasks/)

The website is published by the above hosts on:

* [https://renatoathaydes.github.io/zig-common-tasks/](https://renatoathaydes.github.io/zig-common-tasks/)
* [http://renatoathaydes.mypages.tech/zig-common-tasks/](http://renatoathaydes.mypages.tech/zig-common-tasks/)

Feel free to add to other hosts.
