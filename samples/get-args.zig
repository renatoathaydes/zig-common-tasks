// 
// 
// 
// Get command line arguments
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts heretest "argsWithAllocator - get an iterator, use an allocator" {
    // this seems to be the only portable way to do it.
    const a: std.process.Args = undefined;
    var args = try std.process.Args.Iterator.initAllocator(a, alloc);
    defer args.deinit();
    while (args.next()) |arg| {
        _ = arg; // use arg
    }
} // Sample ends 