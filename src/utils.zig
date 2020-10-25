// --- Util functions  ---

// --- delay ---
// args:
// ms - delay in ms
// return value:
// void
pub fn delay(ms: u16) void {
    var count: u16 = 0;
    const loop_ms = 0x0a52;

    while (count < ms) : (count += 1) {
        var loop: u16 = 0;
        while (loop < loop_ms) : (loop += 1) {
            asm volatile (""
                :
                :
                : "memory"
            );
        }
    }
}

// --- setbit ---
// Set bit (bit) of a register (reg) to a value (value: 0/1)
// args:
// reg (u8) - register to write
// bit (u8)- bit in the register to modify
// value (u1) - value of the bit to set (1/0)
// return value:
// void
pub fn setbit(reg: *volatile u8, comptime bit: u8, value: u1) void {
    const mask: u8 = 1 << bit;

    if (1 == value) {
        reg.* |= mask;
    } else if (0 == value) {
        reg.* &= ~mask;
    }
}

// --- getbit ---
// Get the value of a bit (bit) from register (reg)
// args:
// reg (u8) - register to read
// bit (u8) - bit in the register to get
// return value:
// value (u1) - value of the bit (1/0)

// Example usage of getbit
//var ret: u1 = 0;
//ret = utils.getbit(@ptrToInt(avr.portb), 5);
pub fn getbit(reg: u8, comptime bit: u8) u1 {
    const mask: u8 = 1 << bit;

    return @intCast(u1, reg & mask);
}

// --- getbit ---
// Get the value of a bit (bit) from register (reg)
// args:
// reg (u8) - register to write
// bit (u8) - bit in the register to toggle (change from 0 to 1 and viceversa)
// return value:
// void
pub fn toggle(reg: *volatile u8, comptime bit: u8) void {
    const mask: u8 = 1 << bit;

    reg.* ^= mask;
}