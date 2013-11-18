# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for maguro hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, full and maguro, hence its name.
#

# Device overlay and prebuilt directories
DEVICE_PREBUILT := device/motorola/droid2we/prebuilt

PRODUCT_PACKAGES += \
	audio.primary.omap3 \
	libaudiohw_legacy \
	audio.a2dp.default \
	libaudioutils \
	hcitool \
	hciattach \
	hcidump

# root
PRODUCT_COPY_FILES += \
	device/motorola/droid2we/prebuilt/root/init.rc:root/init.rc \
	device/motorola/droid2we/prebuilt/root/init.mapphone_cdma.rc:root/init.mapphone_cdma.rc \
	device/motorola/droid2we/prebuilt/root/ueventd.mapphone_cdma.rc:root/ueventd.mapphone_cdma.rc

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/motorola/droid2we/prebuilt/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel

# copy all kernel modules under the "modules" directory to system/lib/modules
PRODUCT_COPY_FILES += $(shell \
	find device/motorola/droid2we/modules -name '*.ko' \
	| sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
	| tr '\n' ' ')

PRODUCT_PROPERTY_OVERRIDES += \
	persist.ril.features=0x0E \
	persist.ril.modem.ttydevice=/dev/usb/tty1-3:1.4 \
	persist.ril.mux.noofchannels=8 \
	ro.ril.ntmodeglobal=true

# Inherit from those products. Most specific first.
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# Inherit from droid2we device
$(call inherit-product, device/motorola/droid2we/device.mk)
