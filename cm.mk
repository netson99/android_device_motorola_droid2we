# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/motorola/droid2we/droid2we.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := droid2we
PRODUCT_NAME := cm_droid2we
PRODUCT_BRAND := verizon
PRODUCT_MODEL := DROID2 Global
PRODUCT_MANUFACTURER := Motorola

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=droid2we_vzw BUILD_FINGERPRINT=verizon/droid2we_vzw/cdma_droid2we:2.3.4/4.5.1_57_D2GA-59/120117:user/release-keys PRIVATE_BUILD_DESC="cdma_droid2we-user 2.3.4 4.5.1_57_D2GA-59 120117 release-keys"

TARGET_BOOTANIMATION_NAME := 480
