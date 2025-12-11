// 
// 
// 
// Print something to stdout/stderr
const std = @import("std");

pub fn main() !void {
    hello_world();
}

// Sample starts herepub fn hello_world() !void {
    // to print something for debugging purposes, there's an easy way!
    std.debug.print("Hello world!\n", .{});

    // but on real apps, you will want to use the "real" stdout/stderr

    var buffer: [1024]u8 = undefined;

    // Choose File.stdout() or File.stderr()
    // Note: don't use stdout() in tests, it will block your test on "zig build test"!
    var writer = std.fs.File.stderr().writer(&buffer);
    const stderr = &writer.interface;

    try stderr.print("Hello world!\n", .{});

    // you can provide arguments, similar to C's printf,
    // though in Zig the format is checked at compile-time!
    try stderr.print("number: {d}, string: {s}\n", .{ 42, "fourty-two" });

    try stderr.flush(); // Don't forget to flush!
} //  Sample ends

test "check main" {
    try hello_world();
}
