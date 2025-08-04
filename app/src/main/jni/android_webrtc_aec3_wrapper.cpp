#include <jni.h>

#include <stdlib.h> // for NULL
#include <assert.h>
#include <stddef.h>
#include <unistd.h>
#include <memory>

#include <android/log.h>
#define TAG "APM-AEC3"
#define LOGV(...) __android_log_print(ANDROID_LOG_VERBOSE, TAG, __VA_ARGS__)

#include "com_webrtc_audioprocessing_Aec3.h"
#include "api/audio/audio_processing.h"
#include "modules/audio_processing/audio_processing_impl.h"
#include "api/audio/builtin_audio_processing_builder.h"
#include "api/environment/environment.h"
#include "api/environment/environment_factory.h"
#include "common_audio/channel_buffer.h"
#include "common_audio/include/audio_util.h"

using namespace std;
using namespace webrtc;

static void set_ctx(JNIEnv *env, jobject thiz, void *ctx)
{
    jclass cls = env->GetObjectClass(thiz);
    jfieldID fid = env->GetFieldID(cls, "objData", "J");
    env->SetLongField(thiz, fid, (jlong)ctx);
}

static void *get_ctx(JNIEnv *env, jobject thiz)
{
    jclass cls = env->GetObjectClass(thiz);
    jfieldID fid = env->GetFieldID(cls, "objData", "J");
    return (void *)env->GetLongField(thiz, fid);
}

class ApmWrapper
{
    const int sample_rate_hz = AudioProcessing::kSampleRate16kHz;
    const int num_input_channels = 1;

public:
    ApmWrapper()
        : _env(CreateEnvironment()),
          _input_config(sample_rate_hz, num_input_channels),
          _output_config(sample_rate_hz, num_input_channels)
    {
        AudioProcessing::Config config;
        config.echo_canceller.enabled = true;

        // 创建 builder 并设置配置
        BuiltinAudioProcessingBuilder builder;
        builder.SetConfig(config);
        _apm = builder.Build(_env);
    }

    ~ApmWrapper() {}

    int ProcessStream(int16_t *data)
    {
        // 处理后的数据输出到 output_buffer
        int16_t output_buffer[_input_config.num_frames()];
        // 调用 APM 进行处理
        int ret = _apm->ProcessStream(data, _input_config, _output_config, output_buffer);
        // 将处理后的数据拷贝回 data
        std::copy(output_buffer, output_buffer + _input_config.num_frames(), data);
        return ret;
    }

public:
    scoped_refptr<AudioProcessing> _apm;

private:
    Environment _env;
    StreamConfig _input_config;  // 采样率16kHz，单通道
    StreamConfig _output_config; // 采样率16kHz，单通道
};

#ifdef __cplusplus
extern "C"
{
#endif

    JNIEXPORT jboolean JNICALL Java_com_webrtc_audioprocessing_Apm_nativeCreateApmInstance(JNIEnv *env, jobject thiz, jboolean aecExtendFilter, jboolean speechIntelligibilityEnhance, jboolean delayAgnostic, jboolean beamforming, jboolean nextGenerationAec, jboolean experimentalNs, jboolean experimentalAgc)
    {
        ApmWrapper *apm = new ApmWrapper();

        if (apm == nullptr)
            return JNI_FALSE;
        else
        {
            set_ctx(env, thiz, apm);
            LOGV("created");
            return JNI_TRUE;
        }
    };

    JNIEXPORT void JNICALL Java_com_webrtc_audioprocessing_Apm_nativeFreeApmInstance(JNIEnv *env, jobject thiz)
    {
        ApmWrapper *apm = (ApmWrapper *)get_ctx(env, thiz);
        delete apm;
        LOGV("destroyed");
    };

    JNIEXPORT jint JNICALL Java_com_webrtc_audioprocessing_Apm_ProcessStream(JNIEnv *env, jobject thiz, jshortArray nearEnd, jint offset)
    {
        ApmWrapper *apm = (ApmWrapper *)get_ctx(env, thiz);
        short *buffer = (short *)env->GetShortArrayElements(nearEnd, nullptr);
        int ret = apm->ProcessStream(buffer + offset);
        return ret;
    };

#ifdef __cplusplus
}
#endif
