// {{ define name "Print something to stdout/stderr" }}{{ define id "print-something" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
pub fn main() !void {
    var buffer: [1024]u8 = undefined;

    // Use File.stdout() or File.stderr()
    var writer = std.fs.File.stdout().writer(&buffer);
    const stdout = &writer.interface;

    try stdout.print("Hello world!\n", .{});

    // you can provide arguments, similar to C's printf,
    // though in Zig the format is checked at compile-time!
    try stdout.print("number: {d}, string: {s}\n", .{ 42, "fourty-two" });

    try stdout.flush(); // Don't forget to flush!
} // {{ end }}{{ eval contents }} Sample ends

test "check main" {
    try main();
}
