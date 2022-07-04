// {{ define name "String - check if it contains another" }}{{ define id "string-contains" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Check if a string contains another" {
    const to_find = "string";
    const contains = std.mem.containsAtLeast(u8, "big string", 1, to_find);
    try std.testing.expect(contains);
} // {{ end }}{{ eval contents }} Sample ends
