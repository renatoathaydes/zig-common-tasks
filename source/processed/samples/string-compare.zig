// {{ define name "String - compare two strings" }}{{ define id "string-compare" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Check if two strings are equal ignoring case (ASCII only)" {
    const are_equal = std.ascii.eqlIgnoreCase("hEllO", "Hello");
    try std.testing.expect(are_equal);
}

test "Check if two strings are exactly equal" {
    const are_equal = std.mem.eql(u8, "hello", "hello");
    try std.testing.expect(are_equal);
} // {{ end }}{{ eval contents }} Sample ends
