// {{ define name "String - iterate over UTF-8 code points" }}{{ define id "string-utf8" }}{{ eval name }}
const std = @import("std");

// Sample starts here{{ slot contents }}\
test "Iterate over utf-8 string code points" {
    // reference: https://emojipedia.org/woman-astronaut/
    var utf8_str = (try std.unicode.Utf8View.init("👩‍🚀")).iterator();
    try std.testing.expectEqual(@as(?u21, 0x1F469), utf8_str.nextCodepoint());
    try std.testing.expectEqual(@as(?u21, 0x200D), utf8_str.nextCodepoint());
    try std.testing.expectEqual(@as(?u21, 0x1F680), utf8_str.nextCodepoint());
    try std.testing.expectEqual(@as(?u21, null), utf8_str.nextCodepoint());
} // {{ end }}{{ eval contents }} Sample ends

