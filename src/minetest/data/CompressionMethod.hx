package minetest.data;

enum abstract CompressionMethod(String) {
    var Deflate = "deflate";
    var Zstandard = "zstd";
}
