// {{ define name "JSON - Write object" }}{{ define id "write-json" }}{{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "Write JSON object" {
    const example_json: []const u8 =
        \\{"a_number":10,"a_str":"hello"}
    ;

    var stream = std.ArrayList(u8).init(alloc);
    defer stream.deinit();

    try std.json.stringify(.{
        .a_number = @as(u32, 10),
        .a_str = "hello",
    }, .{}, stream.writer());

    try std.testing.expectEqualSlices(u8, example_json, stream.items);
}
