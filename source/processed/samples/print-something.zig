// {{ define name "Print something to stdout/stderr" }}{{ define id "print-something" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
pub fn main() !void {
    // print to stdout (stderr would be getStdErr() - which has the same type)
    const stdout = std.io.getStdOut();
    try stdout.writeAll("Hello, world!\n");

    // similar construct to printf
    try stdout.writer().print("number: {d}, string: {s}\n", .{ 42, "fourty-two" });
} // {{ end }}{{ eval contents }} Sample ends

