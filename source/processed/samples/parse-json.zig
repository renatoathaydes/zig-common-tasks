// {{ define name "JSON - Parse object" }}{{ define id "parse-json" }}{{ eval name }}
const std = @import("std");

const alloc = std.testing.allocator;

// Sample starts here{{ slot contents }}\
test "Parse JSON object" {
    const example_json: []const u8 =
        \\{"a_number": 10, "a_str": "hello"}
    ;
    const JsonStruct = struct {
        a_number: u32,
        a_str: []const u8
    };

    const parsed = try std.json.parseFromSlice(JsonStruct, alloc, example_json, .{});
    defer parsed.deinit();

    const result = parsed.value;
    try std.testing.expectEqual(@as(u32, 10), result.a_number);
    try std.testing.expectEqualSlices(u8, "hello", result.a_str);
}
