// {{ define name "Boolean logic (if expression, equality)" }}
// {{ define id "boolean-logic" }}
// {{ define category "Basics" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Basic boolean operators" {
    // Zig uses `and` and `or`, unlike many languages that use `&&` and `||`
    try std.testing.expect(true and true);
    try std.testing.expect(false or true);
    // but negation is still done using `!`
    try std.testing.expect(!true or true);
}

test "If expressions" {
    const x = true;
    // Zig does not have the ternary operator (`x ? 1 : 0`), but it has `if` expressions!
    try std.testing.expectEqual(42, if (x) 42 else 0);
}

test "Equality" {
    // testing equality with `==` or `!=` works for numeric types, booleans and types
    try std.testing.expect(2 == 1 + 1);
    try std.testing.expect(false == (2 == 3 + 1));
    try std.testing.expect(@TypeOf(true) == bool);

    // but it doesn't work for other types, such as strings (or slices)
    const array1 = [_]u8{ 1, 2, 3 };
    var array2 = [_]u8{ 3, 2, 1 };
    std.mem.sort(u8, &array2, {}, std.sort.asc(u8));

    // the pointers are NOT the same (comparing arrays would not even compile)
    try std.testing.expect(&array1 != &array2);

    // even if the contents are the same
    try std.testing.expect(std.mem.eql(u8, &array1, &array2));
}
