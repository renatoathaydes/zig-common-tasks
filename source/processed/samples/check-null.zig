// {{ define name "Check for null (to use nullable value)" }}{{ define id "check-null" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Check for null using if statement" {
    var byte: ?u8 = 10;
    var n: u8 = 2;
    if (byte) |b| {
        // b is non-null here
        n += b;
    }
    try std.testing.expectEqual(n, @as(u8, 12));
}

test "Check for null using if expression" {
    var byte: ?u8 = null;
    var n: u8 = if (byte) |b| b else 2;
    try std.testing.expectEqual(n, @as(u8, 2));
} // {{ end }}{{ eval contents }} Sample ends {{ define notes ["The [get-command-line-args](#get-command-line-args) sample shows a while loop used with an iterator which returns null when no more elements are left."] }}
