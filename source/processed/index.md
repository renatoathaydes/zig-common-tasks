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

> All samples are tested on MacOS, Windows and Linux/Ubuntu using the Zig version selected in the selector
> in the top-right corner of this page.

## Contributing

Read instructions on this project repository's README on [GitHub](https://github.com/renatoathaydes/zig-common-tasks/) or [OpenCode](https://www.opencode.net/renatoathaydes/zig-common-tasks/).

## Index

{{ component _toc.html }}
{{ for all (groupBy category) /processed/samples }}
{{ component _category.html }}
### {{ eval all.group }}
{{ for sample (sortBy name) eval all.values }}
[{{ eval sample.name }}](#{{ eval sample.id }})
{{ end }}
{{ end }}
{{ end }}
{{ end }}

## Code samples

<div class='warning'>The Zig Standard Library is currently in flux. Effort is taken to keep all samples up-to-date, but changes are to be expected until it stabilizes after Zig 1.0.</div>

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
