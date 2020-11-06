// --- ATMEGA328p port ---

// --- Constants
// FOSC (16MHz)
pub const CPU_CLOCK_HZ = 16000000;

// --- ENUMS ---


// --- Register Mapping
pub const PORTB = enum(u8) {
    B0,
    B1,
    B2,
    B3,
    B4,
    B5,
    B6,
    B7,
};
pub const pinb = @intToPtr(*volatile u8, 0x23);
pub const ddrb = @intToPtr(*volatile u8, 0x24);
pub const portb = @intToPtr(*volatile u8, 0x25);


// --- Serial Communication
pub const UCSR0A = enum(u8) {
    MPCM0,
    U2X0,
    UPE0,
    DOR0,
    FE0,
    UDRE0,
    TXC0,
    RXC0,
};
pub const ucsr0a = @intToPtr(*volatile u8, 0xC0);

pub const UCSR0B = enum(u8) {
    TXB8,
    RXB80,
    UCSZ02,
    TXEN0,
    RXEN0,
    UDRIE0,
    TXCIE,
    RXCIE0,
};
pub const ucsr0b = @intToPtr(*volatile u8, 0xC1);

pub const UCSR0C = enum(u8) {
    UCPOL0,
    UCSZ00,
    UCSZ01,
    USBS0,
    UPM00,
    UPM01,
    UMSEL00,
    UMSEL01,
};
pub const ucsr0c = @intToPtr(*volatile u8, 0xC2);

pub const ubrr0l = @intToPtr(*volatile u8, 0xC4);
pub const ubrr0h = @intToPtr(*volatile u8, 0xC5);
pub const udr0 = @intToPtr(*volatile u8, 0xC6);


// Timer
pub const tcnt1 = @intToPtr(*volatile u16, 0x84);
pub const tccr1a = @intToPtr(*volatile u8, 0x80);
pub const tccr1b = @intToPtr(*volatile u8, 0x81);
pub const timsk1 = @intToPtr(*volatile u8, 0x6f);

// --- ASM port

// Compiler Barrier
pub fn BARRIER() void {
    asm volatile (""::: "memory");
}

pub fn NOP() void {
    asm volatile ("nop");
}

// Global Interrupt Enable
pub fn ENABLE_INTERRUPTS() void {
    asm volatile ("sei"::: "memory");
}

// Global Interrupt Disable
pub fn DISABLE_INTERRUPTS() void {
    asm volatile ("cli"::: "memory");
}

pub fn ENTER_CRITICAL() void {
    //asm volatile ("in __tmp_reg__, __SREG__");
    DISABLE_INTERRUPTS();
    //asm volatile ("push __tmp_reg__");
    BARRIER();
}

pub fn EXIT_CRITICAL() void {
    //asm volatile ("pop __tmp_reg__");
    //asm volatile ("out __SREG__, __tmp_reg__");
    BARRIER();
}
