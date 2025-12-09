// {{ define name "Socket - accept TCP connections" }}
// {{ define id "socket-accept" }}
// {{ define category "IO and OS facilities" }}
// {{ eval name }}
const std = @import("std");

const alloc: std.mem.Allocator = std.heap.page_allocator;

test "Verify that listener can be created" {
    // FIXME does not work on Windows
    if (@import("builtin").os.tag == .windows) {
        return;
    }
    var listener = try localhostListener(0);
    defer listener.deinit();
}

fn printMessage(reader: anytype) !void {
    var buf: [1024]u8 = undefined;
    const msg = try reader.readUntilDelimiterOrEof(&buf, '\n') orelse "";
    std.debug.print("Got message: {s}", .{msg});
}

// Sample starts here{{ slot contents }}\
fn localhostListener(port: u16) !std.net.Server {
    const localhost = try std.net.Address.resolveIp("0.0.0.0", port);
    return localhost.listen(.{});
}

pub fn main() !void {
    var listener = try localhostListener(8081);
    defer listener.deinit();

    const connection = try listener.accept();
    defer connection.stream.close();

    std.log.info("Accepted connection from {}", .{connection.address});
    try printMessage(&connection.stream.reader());
} // {{ end }}{{ eval contents }} Sample ends {{ define notes ["See also [MasterQ32/zig-network](https://github.com/MasterQ32/zig-network).", "This sample does not work on Windows. Help to fix it welcome."]}}
