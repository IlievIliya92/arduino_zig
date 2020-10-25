// --- Util functions  ---

// --- delay ---
// args:
// ms - delay in ms
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
// args:
// reg - register to maanage
// bit - bit in the register to modify
// value - value of the bit to set (1/0)
pub fn setbit(reg: *volatile u8, comptime bit: u8, value: u2) void {
    const mask: u8 = 1 << bit;

    if (1 == value) {
        reg.* |= mask;
    } else if (0 == value) {
        reg.* &= ~mask;
    }
}
