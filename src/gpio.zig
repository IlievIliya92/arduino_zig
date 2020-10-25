// --- Togle
pub fn toggle(port: *volatile u8, bit: u8) void {
    port.* ^= bit;
}

// --- Enable Output
pub fn enbOutput(port: *volatile u8, bit: u8) void {
    port.* = bit;
}
