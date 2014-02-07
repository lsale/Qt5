#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>


class Logger {
public:
    static void print(QObject*, QString);
};

#endif // LOGGER_H
