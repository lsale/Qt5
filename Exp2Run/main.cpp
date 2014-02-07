#include <QtGui/QGuiApplication>
#include <QtQml>
#include <QQmlEngine>

#include "qtquick2applicationviewer.h"
#include "Timer.h"
#include "QQmlNdefFooRecord.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Timer>("CustomTimer", 1, 0, "Timer");
    qmlRegisterType<QQmlNdefFooRecord>("my.bb.com", 1, 0, "QNdefRecord");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
