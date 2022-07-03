{{ include /processed/fragments/_header.html }}

This website is dedicated to helping programmers perform common tasks in [Zig](https://ziglang.org/).

It is not a tutorial and should be used mostly as a reference.

## Reading the samples

Notice that it's implicit in many code samples:

* `const std = @import("std");` at the top.
* the `alloc` variable is of type `std.mem.Allocator`. See the [allocators](#allocators) sample for how to get one.

**Click on the title of each sample to see its full source.**

## Index

{{ component _toc.html }}
{{ for sample (sortBy name) /processed/samples }}
[{{ eval sample.name }}](#{{ eval sample.id }})
{{ end }}
{{ end }}

## Code samples

{{ for sample (sortBy name) /processed/samples }}
<span id='{{ eval sample.id }}'>[{{ eval sample.name }}]({{ eval sample }})</span>
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
