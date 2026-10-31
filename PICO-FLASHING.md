# Pico flashing on macOS

Installed command: `~/.local/bin/pflash` (source: `bin/pflash`).
The local commands directory is added to zsh PATH. Open a fresh terminal tab.

Connect exactly one RP2040 or RP2350 in BOOTSEL mode, then run:

```sh
pflash --dry-run /path/to/firmware.uf2
pflash /path/to/firmware.uf2
```

The command inspects the image and connected device, unmounts mounted MS-DOS
bootloader volumes named RPI-RP2/RP2350 (including numbered mount-path suffixes),
checks that they are no longer mounted, then uses `picotool load -v -x`.
It does not force application-mode boards to reboot, use sudo, or run a service.
Connect only the board you intend to flash. Pick the correct firmware for it.

The diskutil client wait is bounded to 20 seconds because this Mac exhibited a
completed unmount with a hanging diskutil response. Actual mount state decides
whether flashing can proceed; a failed or still-pending unmount aborts flashing.

This avoids the mounted-disk ejection warning during wrapper-based flashing.
It does not prevent Finder showing a bootloader disk on connection, and does not
suppress warnings if a mounted board is manually unplugged or rebooted.

The earlier /etc/fstab noauto rules remain present but were observed not to
prevent automatic mounting on this Mac. They are not relied on by pflash.

Reinstall after editing the source:

```sh
install -m 755 bin/pflash ~/.local/bin/pflash
```

Verified with a real read-only device probe and --dry-run using the existing
Badger firmware image. Actual flashing was intentionally not performed.
