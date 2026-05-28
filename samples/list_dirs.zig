// 
// 
// 
// List directory contents
const std = @import("std");

// Sample starts heretest "List contents of directory" {
    const io = std.testing.io;

    var children = std.Io.Dir.cwd().openDir(io, "source", .{ .iterate = true }) catch {
        // couldn't open dir
        return;
    };
    defer children.close(io);
    // use the returned iterator to iterate over dir contents
    _ = children.iterate();
} //  Sample ends
