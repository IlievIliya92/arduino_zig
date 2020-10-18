// --- INCLUDES  ---
const avr = @import("atmega328p.zig");

// --- CONTEXT ---
const led_bit: u8 = 1 << 5;

// --- HELPER FUNCTIONS ---
fn toggleLed() void {
  avr.portb.* ^= led_bit;
}

fn delay(duration: i32) void {
  var dur : i32 = duration;
  while (dur > 0) {
    var inner : i32 = 72000 / 10;
    while (inner > 0) {
      inner -= 1;
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
    }
    dur -= 1;
  }
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
