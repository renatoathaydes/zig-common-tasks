// {{ define name "Get command line arguments" }}{{ define id "get-command-line-args" }}{{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "argsWithAllocator - get an iterator, use an allocator" {
    var args = try std.process.argsWithAllocator(alloc);
    defer args.deinit();
    while (args.next()) |arg| {
        _ = arg; // use arg
    }
}

test "argsAlloc - get a slice, use an allocator" {
    var args = try std.process.argsAlloc(alloc);
    defer alloc.free(args);
    for (args) |arg| {
        _ = arg; // use arg
    }
}

test "args - get an iterator, no allocation but not fully portable" {
    var args = std.process.args();
    while (args.next()) |arg| {
        _ = arg; // use arg
    }
} //{{ end }}{{ eval contents }} Sample ends {{ define notes ["the first item in `args` is the program path itself.", "not using the allocator version makes the code less cross-platform."] }}
