# Add more folders to ship with the application, here
folder_01.source = qml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    Timer.cpp \
    Logger.cpp \
    QQmlNdefFooRecord.cpp

QT += qml core nfc multimedia

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    bar-descriptor.xml \
    qml/MyButton.qml \
    qml/victory.qml \
    qml/race.qml \
    qml/CustomCountdown.qml

HEADERS += \
    Timer.h \
    Logger.h \
    QQmlNdefFooRecord.h
