// 
// 
// 
// String - convert to number
const std = @import("std");

// Sample starts heretest "Convert string to number" {
    // base-10 signed integer
    const decimal = try std.fmt.parseInt(i32, "42", 10);
    try std.testing.expectEqual(@as(i32, 42), decimal);

    // floating-point number
    const float = try std.fmt.parseFloat(f64, "3.1415");
    try std.testing.expectEqual(@as(f64, 3.1415), float);

    // base-2 unsigned integer
    const byte = try std.fmt.parseUnsigned(u8, "1_0101", 2);
    try std.testing.expectEqual(@as(u8, 21), byte);
} //  Sample ends

