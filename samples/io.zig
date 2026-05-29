// 
// 
// 
// IO and Future
const std = @import("std");
const alloc = std.testing.allocator;
const expect = std.testing.expect;

// Sample starts here// IO can be obtained from the Init struct, which Zig
// can provide as an argument to the main function,
// or, for testing, from `std.testing.io`.
// See https://ziglang.org/download/0.16.0/release-notes.html#Juicy-Main
pub fn main(init: std.process.Init) !void {
    // An appropriate default Io implementation based on the target configuration.
    // Debug mode will set up leak checking if possible.
    const io = init.io;

    // IO is not normally used directly, but passed around to functions that use IO
    var result: u32 = undefined;
    var future =  io.async(go, .{41, &result});

    defer future.cancel(io);

    // Use this pattern to avoid resource leaks and handle Cancelation gracefully:
    // defer if (future.cancel(io)) |resource| resource.deinit() else |_| {};

    // await the future.
    future.await(io);

    // now, result has been set.
    std.debug.print("Got {d}\\", .{result});
}

fn go(n: u32, result: *u32) void {
    result.* = n + 1;
} // Sample ends