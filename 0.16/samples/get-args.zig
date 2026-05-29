// 
// 
// 
// Get command line arguments
const std = @import("std");

// Sample starts here// Program arguments can be obtained from the Init.Minimal struct, which Zig
// can provide as an argument to the main function.
// See https://ziglang.org/download/0.16.0/release-notes.html#Juicy-Main
pub fn main(init: std.process.Init) !void {
    const min = init.minimal;
    const alloc = init.arena.allocator();

    const args = try min.args.toSlice(alloc);
    for (args, 0..) |arg, i| {
        std.log.info("arg[{d}] = {s}", .{ i, arg });
    }
} // Sample ends 