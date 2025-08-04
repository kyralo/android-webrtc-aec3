# 编译纪要
## 参数
[echo_canceller3.cc](modules/audio_processing/aec3/echo_canceller3.cc) 实际生效类

## 重要函数
virtual void ApplyConfig(const Config& config) = 0;


## 流程
1. 配置参数
通过 AudioProcessing::Config 结构体设置各类处理参数，如回声消除、增益控制等。

关键代码：配置结构体参数

2. 创建 APM 实例
通常通过 BuiltinAudioProcessingBuilder 或类似工厂方法创建 APM 实例。

关键代码：创建 APM 实例

3. 初始化 APM
可以直接调用 Initialize()，或者传入 ProcessingConfig 指定流参数（采样率、通道数等）。

关键代码：初始化 APM，设置流参数

4. 处理音频流
采集到的音频数据通过 ProcessStream 处理，回放数据通过 ProcessReverseStream 处理。

关键代码：处理音频流

5. 运行时参数设置（可选）
如需动态调整参数，可用 SetRuntimeSetting 或 ApplyConfig。

关键代码：运行时参数调整

总结流程
配置参数 → 2. 创建实例 → 3. 初始化 → 4. 处理音频流 → 5.（可选）动态调整参数


## WebRTC 使用 AEC3 处理音频流程（关键方法标出）

1. **配置参数**
   - 使用 `webrtc::AudioProcessing::Config` 设置回声消除（AEC3）等参数。
   - 关键方法：`AudioProcessing::Config`

2. **创建 APM 实例**
   - 通过 `BuiltinAudioProcessingBuilder` 或类似工厂创建 `AudioProcessing` 实例。
   - 关键方法：`BuiltinAudioProcessingBuilder::Build`

3. **初始化 APM**
   - 调用 `AudioProcessing::Initialize`，可传入 `ProcessingConfig` 设置采样率和通道数。
   - 关键方法：`AudioProcessing::Initialize`

4. **应用配置**
   - 调用 `AudioProcessing::ApplyConfig` 应用 AEC3 等参数。
   - 关键方法：`AudioProcessing::ApplyConfig`

5. **处理回放流（远端音频）**
   - 使用 `AudioProcessing::ProcessReverseStream` 处理回放数据，为 AEC3 提供参考。
   - 关键方法：`AudioProcessing::ProcessReverseStream`

6. **处理采集流（本地音频）**
   - 使用 `AudioProcessing::ProcessStream` 处理麦克风采集数据，进行回声消除等处理。
   - 关键方法：`AudioProcessing::ProcessStream`

7. **获取处理结果或统计信息（可选）**
   - 可通过 `AudioProcessing::GetStatistics` 获取处理效果和状态。
   - 关键方法：`AudioProcessing::GetStatistics`

---

**流程总结：**
1. 配置参数  
2. 创建实例  
3. 初始化  
4. 应用配置  
5. 处理回放流  
6. 处理采集流  
7. 获取统计信息（可选）
