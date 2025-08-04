LOCAL_PATH := $(call my-dir)
include $(call all-subdir-makefiles)
include $(CLEAR_VARS)

LOCAL_MODULE := libwebrtc_aec3
LOCAL_C_INCLUDES := $(LOCAL_PATH)

#LOCAL_LDLIBS    += -llog
#LOCAL_LDLIBS    += -landroid
#LOCAL_CFLAGS    += -O0
LOCAL_CPPFLAGS  += -std=c++17

LOCAL_ARM_NEON  := true

LOCAL_CFLAGS    += -DWEBRTC_POSIX
LOCAL_CFLAGS    += -DWEBRTC_ARCH_ARM64
LOCAL_CFLAGS    += -DWEBRTC_ANDROID
LOCAL_CFLAGS    += -DWEBRTC_APM_DEBUG_DUMP=0
LOCAL_CFLAGS    += -DWEBRTC_HAS_NEON
LOCAL_CFLAGS    += -DWEBRTC_LIBRARY_IMPL
LOCAL_CFLAGS    += -DWEBRTC_ENABLE_SYMBOL_EXPORT
LOCAL_CFLAGS    += -D_WINSOCKAPI_
LOCAL_CFLAGS    += -DNDEBUG
LOCAL_CFLAGS    += -DPR_SET_NAME="15"

AEC3_CC_LIST := $(wildcard $(LOCAL_PATH)/android_webrtc_aec3_wrapper.cpp)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/audio_processing_impl.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/aec3/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/audio/builtin_audio_processing_builder.cc)


LOCAL_SRC_FILES := $(AEC3_CC_LIST:$(LOCAL_PATH)/%=%)

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

#include $(BUILD_STATIC_LIBRARY)
include $(BUILD_SHARED_LIBRARY)
