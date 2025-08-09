LOCAL_PATH := $(call my-dir)
include $(call all-subdir-makefiles)
include $(CLEAR_VARS)

LOCAL_MODULE := libwebrtc_aec3
LOCAL_C_INCLUDES := $(LOCAL_PATH)
# LOCAL_C_INCLUDES += $(ANDROID_NDK_HOME)/sources/android/cpufeatures

LOCAL_LDLIBS    += -llog
LOCAL_LDLIBS    += -landroid
LOCAL_CFLAGS    += -O0
LOCAL_CPPFLAGS  += -std=c++17

LOCAL_ARM_NEON  := true

# LOCAL_CFLAGS    += -Wall -Wextra -Werror
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
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/cpu/cpu-features.c)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/absl/base/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/absl/base/internal/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/absl/numeric/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/absl/strings/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/absl/strings/internal/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/audio/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/audio_codecs/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/numerics/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/environment/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/transport/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/rtc_event_log/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/task_queue/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/api/units/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/aec3/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/aec_dump/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/aecm/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/logging/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/include/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/audio_processing/utility/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/modules/utility/source/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/*.c)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/resampler/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/signal_processing/*.c)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/third_party/ooura/fft_size_128/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/third_party/spl_sqrt_floor/*.c)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/common_audio/third_party/*.c)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/synchronization/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/experiments/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/containers/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/numerics/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/strings/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/system/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/rtc_base/memory/*.cc)
AEC3_CC_LIST += $(wildcard $(LOCAL_PATH)/system_wrappers/source/*.cc)

LOCAL_SRC_FILES := $(AEC3_CC_LIST:$(LOCAL_PATH)/%=%)

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

#include $(BUILD_STATIC_LIBRARY)
include $(BUILD_SHARED_LIBRARY)
