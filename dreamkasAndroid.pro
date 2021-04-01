TEMPLATE = app
TARGET = dreamkasAndroid
QT += quick quickcontrols2 widgets

HEADERS += \
        menumodel.h \
        src/include/gui.h \
        src/include/guiThread.h \
        src/include/launcher.h \
        src/include/menu.h \
        src/include/searchGoods.h \
        src/include/toolbar.h \
        src/include/treemodel.h \
        src/treemodelstandard.h

SOURCES += \
        menumodel.cpp \
        src/guiThread.cpp \
        src/main.cpp \
        src/qui.cpp \
        src/searchGoods.cpp \
        src/treemodel.cpp \
        src/treemodelstandard.cpp

#OTHER_FILES = qml/main.qml \
#              qml/components/sale/Button_1.qml \
#              qml/components/sale/ButtonClc.qml \
#              qml/components/sale/line.qml \
#              qml/pages/Calculator.qml \
#              content/calculator.js

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
