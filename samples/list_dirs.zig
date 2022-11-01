// List directory contents
const std = @import("std");

// Sample starts heretest "List contents of directory" {
    var children = std.fs.cwd().openIterableDir("source", .{}) catch {
        // couldn't open dir
        return;
    };
    defer children.close();
    // use the returned iterator to iterate over dir contents
    _ = children.iterate();
} //  Sample ends
