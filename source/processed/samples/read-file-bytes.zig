// {{ define name "Read file bytes" }}
// {{ define id "read-file-bytes" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Read bytes from a file" {
    // current working directory
    const cwd = std.fs.cwd();

    const handle = cwd.openFile("hello.txt",
    // this is the default, so could be just '.{}'
    .{ .mode = .read_only }) catch {
        // file not found
        return;
    };
    defer handle.close();

    // read into this buffer
    var buffer: [64]u8 = undefined;
    const bytes_read = handle.readAll(&buffer) catch unreachable;

    // if bytes_read is smaller than buffer.len, then EOF was reached
    try std.testing.expectEqual(@as(usize, 6), bytes_read);

    const expected_bytes = [_]u8{ 'h', 'e', 'l', 'l', 'o', '\n' };
    try std.testing.expectEqualSlices(u8, &expected_bytes, buffer[0..bytes_read]);
}
