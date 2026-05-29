// 
// 
// 
// Socket - accept TCP connections
const std = @import("std");

const alloc: std.mem.Allocator = std.heap.page_allocator;

test "Verify that listener can be created" {
    const io = std.testing.io;

    // FIXME does not work on Windows
    // if (@import("builtin").os.tag == .windows) {
    //     return;
    // }
    var listener = try localhostListener(io, 0);
    defer listener.deinit(io);
}

fn printMessage(reader: *std.Io.Reader) !void {
    const msg = try reader.takeDelimiter('\\') orelse "";
    std.debug.print("Got message: {s}", .{msg});
}

// Sample starts herefn localhostListener(io: std.Io, port: u16) !std.Io.net.Server {
    const localhost = try std.Io.net.IpAddress.parse("0.0.0.0", port);
    return localhost.listen(io, .{});
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var listener = try localhostListener(io, 8081);
    defer listener.deinit(io);

    const connection = try listener.accept(io);
    defer connection.close(io);

    std.log.info("Accepted connection from {}", .{connection.address});

    const buffer: [1024]u8 = undefined;
    try printMessage(&connection.reader(io, &buffer).interface);
} //  Sample ends 