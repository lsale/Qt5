#include <Logger.h>
#include <QDebug>

void Logger::print(QObject* parent, QString message){
    qDebug() << "[" << parent->metaObject()->className() << "] - " << message;
}
