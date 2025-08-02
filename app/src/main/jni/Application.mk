#APP_ABI := armeabi-v7a arm64-v8a
APP_ABI := arm64-v8a
# APP_STL := c++_shared  # 使用stl动态库，需同步将标准库放同目录中，减小内存
# APP_STL := c++_static  # 使用stl静态库，直接将标准库嵌入到so库中，增大内存
APP_STL := c++_static
APP_PLATFORM := android-21
APP_CPPFLAGS := -fno-rtti -fexceptions
APP_CPPFLAGS := -latomic
