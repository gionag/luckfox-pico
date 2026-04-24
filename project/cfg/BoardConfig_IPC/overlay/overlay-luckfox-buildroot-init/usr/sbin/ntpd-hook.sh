#!/bin/sh
# busybox ntpd -S hook. Invoked on every successful sync event
# (args: freq_drift_ppm offset stratum poll_interval; $1 often "step"
# or "stratum"). We don't care about the args — we just want the
# system clock mirrored back into the RTC so the next boot starts
# from a sane wall-time, not 1970, before ntpd has a chance to land
# its first sync.
#
# `hwclock -w` writes system time to the RTC chip (driven by
# CONFIG_RTC_DRV_ROCKCHIP on this kernel). Silently tolerates the
# edge case where the RTC is absent on some variants.
hwclock -w 2>/dev/null || true
