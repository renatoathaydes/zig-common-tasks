// 
// 
// 
// Socket - send data
const std = @import("std");

test "Verify that code compiles" {
    // this sample is meant to be run together with socket-listen.zig
}

// Sample starts herepub fn main() !void {
    const remote = try std.net.Address.resolveIp("0.0.0.0", 8081);
    var remote_stream = try std.net.tcpConnectToAddress(remote);
    defer remote_stream.close();
    try remote_stream.writer().writeAll("hello from Zig\n");
} //  Sample ends 