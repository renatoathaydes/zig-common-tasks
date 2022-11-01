// {{ define name "List directory contents" }}{{ define id "list-dirs" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "List contents of directory" {
    var children = std.fs.cwd().openIterableDir("source", .{}) catch {
        // couldn't open dir
        return;
    };
    defer children.close();
    // use the returned iterator to iterate over dir contents
    _ = children.iterate();
} // {{ end }}{{ eval contents }} Sample ends
