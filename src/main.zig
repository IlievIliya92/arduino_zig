// --- IMPORTS  ---
const gpio = @import("gpio.zig");

// --- MAIN ---
export fn main() noreturn {
    gpio.init();

    while (true) {
        gpio.heartBeat(1000);
    }
}
