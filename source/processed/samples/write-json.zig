// {{ define name "JSON - Write object" }}{{ define id "write-json" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Write JSON object" {
    const example_json: []const u8 =
        \\{"a_number":10,"a_str":"hello"}
    ;

    var buffer: [256]u8 = undefined;
    var writer = std.Io.Writer.fixed(&buffer);

    try std.json.Stringify.value(.{
        .a_number = @as(u32, 10),
        .a_str = "hello",
    }, .{}, &writer);

    try std.testing.expectEqualSlices(u8, example_json, buffer[0..writer.end]);
}
