// String - compare two strings
const std = @import("std");

// Sample starts heretest "Check if two strings are equal ignoring case (ASCII only)" {
    const are_equal = std.ascii.eqlIgnoreCase("hEllO", "Hello");
    try std.testing.expect(are_equal);
}

test "Check if two strings are exactly equal" {
    const are_equal = std.mem.eql(u8, "hello", "hello");
    try std.testing.expect(are_equal);
} //  Sample ends
