// {{ define name "Socket - send data" }}{{ define id "socket-request" }}{{ eval name }}
const std = @import("std");

test "Verify that code compiles" {
    // this sample is meant to be run together with socket-listen.zig
}

// Sample starts here{{ slot contents }}\
pub fn main() !void {
    const remote = try std.net.Address.resolveIp("127.0.0.1", 8081);
    var remote_stream = try std.net.tcpConnectToAddress(remote);
    defer remote_stream.close();
    try remote_stream.writer().writeAll("hello from Zig\n");
} // {{ end }}{{ eval contents }} Sample ends {{ define notes ["See also [MasterQ32/zig-network](https://github.com/MasterQ32/zig-network)."]}}
