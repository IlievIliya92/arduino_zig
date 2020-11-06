// --- IMPORTS  ---
const gpio = @import("gpio.zig");
const serial = @import("serial.zig");

const Uart = serial.Uart;


// --- MAIN ---
export fn main() noreturn {
    var txBytes: usize = 0;

    gpio.init();
    var uart = Uart.new(serial.eCOMPort.USART0, serial.BAUD_RATE_U2Xn.BPS_115200);

    while (true) {
        gpio.heartBeat(1000);
        txBytes = uart.put_string("Test String");
    }
}
