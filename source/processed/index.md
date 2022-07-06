{{ include /processed/fragments/_header.html }}

This website is dedicated to helping programmers perform common tasks in [Zig](https://ziglang.org/).

It is not a tutorial and should be used mostly as a reference.

## Known Hosts

* [https://renatoathaydes.github.io/zig-common-tasks/](https://renatoathaydes.github.io/zig-common-tasks/)
* [http://renatoathaydes.mypages.tech/zig-common-tasks/](http://renatoathaydes.mypages.tech/zig-common-tasks/)

## Reading the samples

Notice that it's implicit in many code samples:

* `const std = @import("std");` at the top.
* the `alloc` variable is of type `std.mem.Allocator`. See the [allocators](#allocators) sample for how to get one.
* Zig's multi-line strings are rendered incorrectly: `\\\ Foo` is shown as `\ Foo`, with a red slash.
  This is hard to fix due to the bug being in an [unmaintained Go library](https://github.com/russross/blackfriday) used to convert markdown to HTML. Once Zig has such library, maybe we'll switch to that and the problem will be gone :)!

> All samples are tested on MacOS, Windows and Linux/Ubuntu using the Zig version declared in
> [.github/workflows/test.yml](https://github.com/renatoathaydes/zig-common-tasks/blob/main/.github/workflows/test.yml).

## Contributing

Read instructions on this project repository's README on [GitHub](https://github.com/renatoathaydes/zig-common-tasks/) or [OpenCode](https://www.opencode.net/renatoathaydes/zig-common-tasks/).

## Index

{{ component _toc.html }}
{{ for sample (sortBy name) /processed/samples }}
[{{ eval sample.name }}](#{{ eval sample.id }})
{{ end }}
{{ end }}

## Code samples

{{ for sample (sortBy name) /processed/samples }}
<span id='{{ eval sample.id }}'>
<a href="{{ eval baseURL + sample }}">{{ eval sample.name }}</a>
</span>
{{ define _forceMarkdown 1 }}\
```zig
{{ eval sample.contents }}
```
{{ if sample.notes != nil }}\
Notes:
<ul>
{{ for note eval sample.notes }}\
<li>{{ eval note }}</li>
{{ end }}\
</ul>
{{ end }}\
<hr>
{{ end }}\


{{ include /processed/fragments/_footer.html }}
