# 1. 架构和目标系统（必须放在最上面！）
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

# 2. 引入公共环境
include $(THEOS)/makefiles/common.mk

# 3. 插件核心配置
TWEAK_NAME = MyTweak
MyTweak_FILES = Tweak.x
MyTweak_CFLAGS = -fobjc-arc
MyTweak_FRAMEWORKS = UIKit Foundation

# 4. 引入编译规则
include $(THEOS_MAKE_PATH)/tweak.mk
