// Parse JSON
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts heretest "Parse JSON scalar (number, string...)" {
    var value = std.json.TokenStream.init("123456");
    const number = try std.json.parse(i64, &value, .{});
    try std.testing.expectEqual(@as(i64, 123456), number);

    value = std.json.TokenStream.init(
        \"hello JSON"
    );

    // an allocator must be provided if allocation is needed
    const string = try std.json.parse([]const u8, &value, .{ .allocator = alloc });

    // allocated values are freed by calling parseFree with the same options as parse
    defer std.json.parseFree([]const u8, string, .{ .allocator = alloc });

    try std.testing.expectEqualSlices(u8, "hello JSON", string);
}

/// Example struct to be parsed from JSON object.
const MyObject = struct {
    myField: u32,
};

test "Parse complex types (array, object)" {
    var value = std.json.TokenStream.init("[1,2,3]");
    const numbers = try std.json.parse([]i64, &value, .{ .allocator = alloc });
    defer std.json.parseFree([]i64, numbers, .{ .allocator = alloc });

    try std.testing.expectEqualSlices(i64, &[_]i64{ 1, 2, 3 }, numbers);

    value = std.json.TokenStream.init(
        \{ "myField": 10, "ignore": true }
    );
    const object = try std.json.parse(MyObject, &value, .{ .allocator = alloc, .ignore_unknown_fields = true });
    defer std.json.parseFree(MyObject, object, .{ .allocator = alloc });

    try std.testing.expectEqual(@as(u32, 10), object.myField);
} //  Sample ends

