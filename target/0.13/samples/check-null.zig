// Check for null (using nullable value)
const std = @import("std");

// Sample starts heretest "Use value orelse a default" {
    const byte: ?u8 = null;
    const n: u8 = byte orelse @as(u8, 0);
    try std.testing.expectEqual(n, @as(u8, 0));
}

test "Check for null using if statement" {
    const byte: ?u8 = 10;
    var n: u8 = 2;
    if (byte) |b| {
        // b is non-null here
        n += b;
    }
    try std.testing.expectEqual(n, @as(u8, 12));
}

test "Check for null using if expression" {
    const byte: ?u8 = null;
    const n: u8 = if (byte) |b| b + 1 else 2;
    try std.testing.expectEqual(n, @as(u8, 2));
} //  Sample ends 