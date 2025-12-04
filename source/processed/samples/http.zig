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
    const read_buffer = try alloc.alloc(u8, 8 * 1024);
    defer alloc.free(read_buffer);
    const write_buffer = try alloc.alloc(u8, 8 * 1024);
    defer alloc.free(write_buffer);
    var con_reader = client_con.stream.reader(read_buffer);
    var con_writer = client_con.stream.writer(write_buffer);
    var server = http.Server.init(con_reader.interface(), &con_writer.interface);
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

    // create a GET request with some headers
    var req = try client.request(http.Method.GET, uri, .{ .headers = .{
        .user_agent = .{ .override = "zig-example-http-client" },
    }, .extra_headers = &.{.{ .name = "Accept", .value = "text/plain" }} });
    defer req.deinit();

    // send it!
    try req.sendBodiless();

    // receive the request header
    var response = try req.receiveHead(&.{});

    // first, make sure the status code was 200 OK
    try std.testing.expectEqual(.ok, response.head.status);

    // we can iterate over the response headers
    var resp_headers = response.head.iterateHeaders();
    var content_type_found = false;
    var content_length: usize = 0;
    while (resp_headers.next()) |header| {
        if (std.ascii.eqlIgnoreCase(header.name, "Content-Length")) {
            content_length = try std.fmt.parseUnsigned(usize, header.value, 10);
        } else if (std.ascii.eqlIgnoreCase(header.name, "Content-Type")) {
            content_type_found = true;
            try std.testing.expectEqualSlices(u8, header.value, "text/plain");
        }
    }
    try std.testing.expectEqual(@as(usize, 6), content_length);
    try std.testing.expect(content_type_found);

    // read the full response body
    const body = try alloc.alloc(u8, content_length);
    defer alloc.free(body);
    var body_reader = response.reader(body);
    try body_reader.fill(content_length);

    // assert the response body is as expected
    try std.testing.expectEqual(6, body.len);
    const expected_body = "Hello\n";
    try std.testing.expectEqualSlices(u8, expected_body, body);
}
