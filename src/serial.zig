// --- IMPORTS  ---
const utils = @import("utils.zig");
const avr = @import("atmega328p.zig");

// --- COMM INTERFACES ---
pub const eCOMPort = enum(u3) {
    USART0,
    MSPIM0,
    USART1,
    MSPIM1,
    USART2,
    MSPIM2,
    USART3,
    MSPIM3,
};

pub const BAUD_RATE = enum(u16) {
    BPS_2400 = 416, // 2400bps
    BPS_4800 = 207, // 4800bps
    BPS_9600 = 103, // 9600bps
    BPS_14400 = 68, // 14.4k bps
    BPS_19200 = 51, // 19.2k bps
    BPS_28800 = 34, // 28.8k bps
    BPS_38400 = 25, // 38.4k bps
    BPS_57600 = 16, // 57.6k bps
    BPS_76800 = 12, // 76.8k bps
    BPS_115200 = 8, // 115.2k bps
    BPS_230400 = 3, // 230.4k bps
};

pub const BAUD_RATE_U2Xn = enum(u16) {
    BPS_2400 = 832, // 2400bps
    BPS_4800 = 416, // 4800bps
    BPS_9600 = 207, // 9600bps
    BPS_14400 = 138, // 14.4k bps
    BPS_19200 = 103, // 19.2k bps
    BPS_28800 = 68, // 28.8k bps
    BPS_38400 = 51, // 38.4k bps
    BPS_57600 = 34, // 57.6k bps
    BPS_76800 = 25, // 76.8k bps
    BPS_115200 = 16, // 115.2k bps
    BPS_230400 = 8, // 230.4k bps
};

pub fn init(port: eCOMPort, baudRate: BAUD_RATE_U2Xn) void {

    avr.ENTER_CRITICAL();

    switch (port) {
        .USART0 => {
            // As the 16MHz Arduino boards have bad karma for serial port, we're using the 2x clock U2X0 */
            // for Arduino at 16MHz;
            // This provides correct rounding truncation to get closest to correct speed.
            // Normal mode gives 3.7% error, which is too much. Use 2x mode gives 2.1% error.
            // for 2x mode, using 16 bit avr-gcc capability.
            avr.ubrr0h.* = @intCast(u8, @shrExact(@enumToInt(baudRate), 8));
            avr.ubrr0l.* = @intCast(u8, (@enumToInt(baudRate)));

            // Enable 2x mode
            utils.setbit(avr.ucsr0a, @enumToInt(avr.UCSR0A.U2X0), 1);

            // Enable the Rx and Tx. Also enable the Rx interrupt. The Tx interrupt will get enabled later. */
            avr.ucsr0b.* = utils.bitMask(@enumToInt(avr.UCSR0B.RXCIE0)) |
                           utils.bitMask(@enumToInt(avr.UCSR0B.RXEN0)) |
                           utils.bitMask(@enumToInt(avr.UCSR0B.TXEN0));

            // Set the data bit register to 8n2. Two Stop Bits only affects transmitter.*/
            avr.ucsr0c.* = utils.bitMask(@enumToInt(avr.UCSR0C.USBS0)) |
                          utils.bitMask(@enumToInt(avr.UCSR0C.UCSZ01)) |
                          utils.bitMask(@enumToInt(avr.UCSR0C.UCSZ00));
        },
        else => {},
    }

    avr.EXIT_CRITICAL();
}

pub fn sendChar(char: u8) void {
    // Wait for empty transmit buffer
    // When UDRE0 = 0,data transmisson ongoing.
    //So NOT{[UCSR0A & (1<<UDRE0)] = 0} = 1 ,While(1) loop stays there
    //When UDRE0 = 1,data transmisson completed.
    //So NOT{[UCSR0A & (1<<UDRE0)] = 1} = 0 ,While(0) loop fails
    while (utils.getbit(@ptrToInt(avr.ucsr0a), @enumToInt(avr.UCSR0A.UDRE0)) == 1)
    {
        utils.delay(1);
    }

    avr.udr0.* = char;
}


