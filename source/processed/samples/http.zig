// {{ define name "HTTP Server and Client" }}{{ define id "http" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
const http = std.http;
const alloc = std.testing.allocator;

fn server_starter() !void {
    const server_address = try std.net.Address.resolveIp("127.0.0.1", 8080);
    var server = try server_address.listen(.{ .reuse_address = true });

    // This would normally be an infinite loop!
    // But for testing, we only handle a single request and stop.
    const client_con = server.accept() catch |err| {
        std.log.err("Unable to accept client connection: {s}", .{@errorName(err)});
        return;
    };
    handle_connection(client_con) catch |err| {
        std.log.err("Failed to handle request: {s}", .{@errorName(err)});
        return;
    };
}

/// Handles connection by always responding with a hardcoded response (ok for GET, method_not_allowed otherwise).
/// Normally you would inspect the request and spawn a new Thread (or use async, coming soon to Zig!).
fn handle_connection(client_con: std.net.Server.Connection) !void {
    defer client_con.stream.close();
    const req_buffer = try alloc.alloc(u8, 8 * 1024);
    defer alloc.free(req_buffer);
    var server = http.Server.init(client_con, req_buffer);
    var req = try server.receiveHead();
    if (req.head.method == .GET) {
        try req.respond("Hello\n", .{ .extra_headers = &.{.{ .name = "Content-Type", .value = "text/plain" }} });
    } else {
        try req.respond("", .{ .status = .method_not_allowed });
    }
}

test "HTTP Server and HTTP Client" {
    // The Server needs to run on a separate Thread.
    const server_thread = try std.Thread.spawn(.{ .allocator = alloc }, server_starter, .{});
    defer server_thread.join();

    // Create a HTTP client that will send a single request to the Server.
    var client = http.Client{ .allocator = alloc };
    defer client.deinit();

    const uri = try std.Uri.parse("http://localhost:8080/hello");
    const headers = try alloc.alloc(u8, 4 * 1024);
    defer alloc.free(headers);

    var req = try client.open(http.Method.GET, uri, .{ .server_header_buffer = headers });
    defer req.deinit();

    // send and wait for a full response
    try req.send();
    try req.wait();

    // first, make sure the status code was 200 OK
    try std.testing.expectEqual(.ok, req.response.status);

    // read the full response body
    var body_reader = req.reader();
    const body = try body_reader.readAllAlloc(alloc, 1024);
    defer alloc.free(body);

    // assert the response body is as expected
    try std.testing.expectEqual(6, body.len);
    const expected_body = "Hello\n";
    try std.testing.expectEqualSlices(u8, expected_body, body);
}
