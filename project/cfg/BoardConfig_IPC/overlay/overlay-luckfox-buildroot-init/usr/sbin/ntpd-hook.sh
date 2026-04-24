#!/bin/sh
# busybox ntpd -S hook. Invoked on every successful sync event
# (args: freq_drift_ppm offset stratum poll_interval; $1 often "step"
# or "stratum"). We don't care about the args — we just want the
# system clock mirrored back into the RTC so the next boot starts
# from a sane wall-time, not 1970, before ntpd has a chance to land
# its first sync.
#
# `hwclock -wu` writes the current UTC system time to the RTC chip
# (driven by CONFIG_RTC_DRV_ROCKCHIP on this kernel). -u forces UTC
# storage so the kernel's boot-time RTC-to-system copy comes up in
# UTC as well; without -u busybox hwclock writes local time to the
# RTC, and the kernel reads it back as UTC at next boot → system
# clock comes up off by TZ offset (+2h in CEST) until ntpd resyncs.
# Silently tolerates the edge case where the RTC is absent on some
# variants.
hwclock -wu 2>/dev/null || true
