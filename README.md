## Arduino ZIG blinking LED

Arduino UNO (atmega328p) blink led implemented in zig

This guide is intended for Ubuntu distributions.

#### 1. Install the zig toolchain:
1. Download the latest stable release from github:
https://github.com/ziglang/zig/releases/
2. Extract the contents of the release file.
3. Create a symbolic link to the zig binary in the /usr/local/bin (so it can be accessed by all users and paths)
    sudo ln -s [path_to_zig_release_contents]/zig /usr/local/bin/zig

#### 2. Build the project
    source setup
    install_packages
    build


#### 3. Upload to the target
    deploy [name_of_the_serial_device]
