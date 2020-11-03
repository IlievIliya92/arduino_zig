// --- IMPORTS  ---
const gpio = @import("gpio.zig");
const serial = @import("serial.zig");

// --- MAIN ---
export fn main() noreturn {
    gpio.init();
    serial.init(serial.eCOMPort.USART0, serial.BAUD_RATE_U2Xn.BPS_9600);

    while (true) {
        gpio.heartBeat(1000);
        serial.sendChar('a');
    }
}
