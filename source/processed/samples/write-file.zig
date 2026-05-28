// {{ define name "Write to file" }}
// {{ define id "write-file" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Write bytes to a file (create if necessary, append or replace contents)" {
    const io = std.testing.io;

    // current working directory
    const cwd = std.Io.Dir.cwd();

    const file_path = "hello.txt";

    const handle = try cwd.createFile(io, file_path, .{
        // set to true to fully replace the contents of the file
        .truncate = false,
    });
    defer handle.close(io);
    defer cwd.deleteFile(io, file_path) catch unreachable;

    var write_buffer: [1024]u8 = undefined;

    var w = handle.writer(io, &write_buffer);
    var writer = w.interface;

    // go to the end of the file if you want to append to the file
    // and `truncate` was set to `false` (otherwise this is not needed)
    try w.seekToUnbuffered(writer.end);

    // write bytes to the file
    const bytes_written = try writer.write("hello Zig\n");

    try std.testing.expectEqual(@as(usize, 10), bytes_written);
}
