// --- ATMEGA328p port ---

// --- ENUMS ---
pub const PORTB = enum(u3) {
    B0,
    B1,
    B2,
    B3,
    B4,
    B5,
    B6,
    B7,
};

// --- Register Mapping
pub const pinb = @intToPtr(*volatile u8, 0x23);
pub const ddrb = @intToPtr(*volatile u8, 0x24);
pub const portb = @intToPtr(*volatile u8, 0x25);

// --- ASM
// Global Interrupt Enable
pub fn sei() void {
    asm volatile ("sei"
        :
        :
        : "memory"
    );
}

// Global Interrupt Disable
pub fn cli() void {
    asm volatile ("cli"
        :
        :
        : "memory"
    );
}

