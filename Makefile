include theos/makefiles/common.mk
export ARCHS = armv7
BUNDLE_NAME = NyanCatVelox
NyanCatVelox_FILES = NyanCatVeloxFolderView.mm
NyanCatVelox_INSTALL_PATH = /Library/Velox/Plugins/
NyanCatVelox_FRAMEWORKS = Foundation UIKit AVFoundation

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"