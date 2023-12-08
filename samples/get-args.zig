// Get command line arguments
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts heretest "argsWithAllocator - get an iterator, use an allocator" {
    var args = try std.process.argsWithAllocator(alloc);
    defer args.deinit();
    while (args.next()) |arg| {
        _ = arg; // use arg
    }
}

test "argsAlloc - get a slice, use an allocator" {
    var args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);
    for (args) |arg| {
        _ = arg; // use arg
    }
}

test "args - get an iterator, no allocation but not fully portable" {
    const builtin = @import("builtin");
    var args =
        if (builtin.os.tag == .windows or builtin.os.tag == .wasi)
        // this sample does not work on Windows and WASI
        return
    else
        // Linux, MacOS etc. can use the simpler args() method:
        std.process.args();

    while (args.next()) |arg| {
        _ = arg; // use arg
    }
} // Sample ends 