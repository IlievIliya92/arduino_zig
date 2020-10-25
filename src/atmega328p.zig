// --- ATMEGA328p port ---

// --- ENUMS ---

// --- PORTB MAP ---
pub const PORTB = enum(u3) {
    B0,
    B1,
    B2,
    B3,
    B4,
    B5,
    B6,
    B7,
};

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

// --- Register Mapping
pub const pinb = @intToPtr(*volatile u8, 0x23);
pub const ddrb = @intToPtr(*volatile u8, 0x24);
pub const portb = @intToPtr(*volatile u8, 0x25);

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
    asm volatile ("in __tmp_reg__, __SREG__");
    DISABLE_INTERRUPTS();
    asm volatile ("push __tmp_reg__");
    BARRIER();
}

pub fn EXIT_CRITICAL() void {
    asm volatile ("pop __tmp_reg__");
    asm volatile ("out __SREG__, __tmp_reg__");
    BARRIER();
}
