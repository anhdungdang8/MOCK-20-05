QT += quick multimedia widgets core
CONFIG += c++11
RC_ICONS +=Icons/Music_29918.ico
include(dependencies/dependencies.pri)
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Control/MediaControl.cpp \
        Model/ListMusicModel.cpp \
        Model/ListVideoModel.cpp \
        Model/MediaModel.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

INCLUDEPATH+= $$PWD/Control
INCLUDEPATH+= $$PWD/Model



HEADERS += \
    Control/MediaControl.h \
    Model/ListMusicModel.h \
    Model/ListVideoModel.h \
    Model/MediaModel.h

DISTFILES +=

