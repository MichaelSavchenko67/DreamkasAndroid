TEMPLATE = app
TARGET = dreamkasAndroid
QT += quick quickcontrols2 widgets core5compat

CONFIG += sdk_no_version_check

INCLUDEPATH += src/include

HEADERS += \
        src/include/cashlessPayModel.h \
        src/include/menuDisplayModel.h \
        src/include/modelDemoSwipe.h \
        src/include/gui.h \
        src/include/guiThread.h \
        src/include/launcher.h \
        src/include/menu.h \
        src/include/searchGoods.h \
        src/include/toolbar.h \
        src/include/menuModelTree.h

SOURCES += \
        src/cashlessPayModel.cpp \
        src/menuDisplayModel.cpp \
        src/modelDemoSwipe.cpp \
        src/guiThread.cpp \
        src/main.cpp \
        src/qui.cpp \
        src/searchGoods.cpp \
        src/menuModelTree.cpp

RESOURCES += \
        qtquickcontrols2.conf \
        dreamkasAndroid.qrc

target.path = $$PWD/build
INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/theme.xml \
    android/res/values/libs.xml \
    android/res/drawable/splash.xml \
    android/res/drawable/icon.png

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ANDROID_ABIS = armeabi-v7a

QMAKE_INFO_PLIST = $$PWD/ios/Info.plist
