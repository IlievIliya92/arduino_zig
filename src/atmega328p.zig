// --- ATMEGA328p port ---
pub const ddrb = @intToPtr(*volatile u8, 0x24);
pub const portb = @intToPtr(*volatile u8, 0x25);
