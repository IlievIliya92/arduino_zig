// --- INCLUDES  ---
const avr = @import("atmega328p.zig");

// --- CONTEXT ---
const led_bit: u8 = 1 << 5;

// --- HELPER FUNCTIONS ---
fn toggleLed() void {
  avr.portb.* ^= led_bit;
}

// --- MAIN ---
export fn main() noreturn {
  avr.ddrb.* = led_bit;
  avr.portb.* = led_bit;

  while (true) {
    toggleLed();
    delay(100);
  }
}
