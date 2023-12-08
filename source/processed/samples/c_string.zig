// {{ define name "C interop - Strings" }}{{ define id "c-interop-strings" }}{{ eval name }}
const std = @import("std");
const alloc = std.testing.allocator;
const expect = std.testing.expect;

// Sample starts here{{ slot contents }}\
const c = @cImport({
    // normally you would include headers or even c files, like this:
    //@cInclude("test.c");
    // but for this sample, C code is directly defined here
    @cDefine("MY_C_CODE", "()\nconst char* give_str() { return \"Hello C\"; }");
});

// use mem.span to convert strings to slices
const span = std.mem.span;

test "Handling C strings" {
    // cstr has type '[*c]const u8' here, but can be coerced to a Zig pointer
    const cstr = c.give_str();
    // notice how Zig String literals are also 0-terminated
    const hz: [*:0]const u8 = "Hello Zig";
    const hc: [*:0]const u8 = "Hello C";

    // calling "span" turns sentinel-terminated values into slices
    const hzSlice: []const u8 = span(hz);

    try expect(!std.mem.eql(u8, span(cstr), hzSlice));
    try expect(std.mem.eql(u8, span(cstr), span(hc)));
}

