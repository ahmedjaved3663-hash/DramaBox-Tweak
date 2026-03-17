TARGET := iphone:clang:latest:15.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DramaBoxUnlock
DramaBoxUnlock_FILES = Tweak.x
DramaBoxUnlock_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
