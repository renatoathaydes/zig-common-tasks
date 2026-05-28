// {{ define name "List directory contents" }}
// {{ define id "list-dirs" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "List contents of directory" {
    const io = std.testing.io;

    var children = std.Io.Dir.cwd().openDir(io, "source", .{ .iterate = true }) catch {
        // couldn't open dir
        return;
    };
    defer children.close(io);
    // use the returned iterator to iterate over dir contents
    _ = children.iterate();
} // {{ end }}{{ eval contents }} Sample ends
