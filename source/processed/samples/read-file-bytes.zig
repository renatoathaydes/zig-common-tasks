// {{ define name "Read file bytes" }}
// {{ define id "read-file-bytes" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Read bytes from a file" {
    const io = std.testing.io;

    // current working directory
    const cwd = std.Io.Dir.cwd();

    const handle = cwd.openFile(io, "hello.txt",
        // this is the default, so could be just '.{}'
        .{ .mode = .read_only }) catch {
        // file not found
        return;
    };
    defer handle.close(io);

    // create a Reader with a temp buffer
    var temp_buffer: [4096]u8 = undefined;
    var reader_impl = handle.reader(io, &temp_buffer);
    var reader = &reader_impl.interface;

    // read into this buffer, fails if cannot fill up the buffer
    var buffer: [6]u8 = undefined;
    reader.readSliceAll(&buffer) catch unreachable;

    const expected_bytes = [_]u8{ 'h', 'e', 'l', 'l', 'o', '\n' };
    try std.testing.expectEqualSlices(u8, &expected_bytes, &buffer);
}
