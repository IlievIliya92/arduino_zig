// --- Util functions  ---

// --- delay ---
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