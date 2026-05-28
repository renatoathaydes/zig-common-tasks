// {{ define name "Get command line arguments" }}
// {{ define id "get-command-line-args" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "argsWithAllocator - get an iterator, use an allocator" {
    // this seems to be the only portable way to do it.
    const a: std.process.Args = undefined;
    var args = try std.process.Args.Iterator.initAllocator(a, alloc);
    defer args.deinit();
    while (args.next()) |arg| {
        _ = arg; // use arg
    }
} //{{ end }}{{ eval contents }} Sample ends {{ define notes ["the first item in `args` is the program path itself.", "not using the allocator version makes the code less cross-platform."] }}
