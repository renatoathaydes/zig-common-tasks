// 
// 
// 
// String - check if it contains another
const std = @import("std");

// Sample starts heretest "Check if a string contains another" {
    const to_find = "string";
    const contains = std.mem.containsAtLeast(u8, "big string", 1, to_find);
    try std.testing.expect(contains);
} //  Sample ends
