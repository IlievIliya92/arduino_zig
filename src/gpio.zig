// --- IMPORTS  ---
const utils = @import("utils.zig");
const avr = @import("atmega328p.zig");

// --- ENUMS ---
const DataDirection = enum(u1) {
    in,
    out,
};

// --- Local Variables & Constants

// --- Local Functions

// --- set DDR (Data Direction Register) ---
// args:
// port (u8) - port to modify
// bit (u8) - bit to set as in/output
// bit (u8) - bit to set as in/output
// return value:
// void
// The DDxn bit in the DDRx register selects the direction of this pin.
// If DDxn is written logic one, Pxn is configured as an output pin.
// If DDxn is written logic zero, Pxn is configured as an input pin.
fn setDDR(port: *volatile u8, comptime bit: u8, direction: DataDirection)  void {
    utils.setbit(port, bit, @enumToInt(direction));
}

// --- Interface Functions

// HeartBeat function
// args:
// return value:
// void
pub fn heartBeat(ms: u16) void {
    utils.toggle(avr.portb, 5);
    utils.delay(ms);
}

pub fn init() void {
    // Set PORTB 5 to be output
    setDDR(avr.ddrb, 5, DataDirection.out);
}