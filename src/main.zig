// --- IMPORTS  ---
const avr = @import("atmega328p.zig");
const utils = @import("utils.zig");
const gpio = @import("gpio.zig");

// --- CONTEXT ---
const led_bit: u8 = 1 << 5;

// --- MAIN ---
export fn main() noreturn {
  gpio.enbOutput(avr.ddrb, led_bit);

  while (true) {
    gpio.toggle(avr.portb, led_bit);
    utils.delay(1000);
  }
}
