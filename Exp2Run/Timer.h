#ifndef TIMER_H
#define TIMER_H
#include <QObject>
#include <QTimer>

class Timer : public QObject
{
    Q_OBJECT

public:
    explicit Timer();
    virtual ~Timer();
    bool isActive();

public slots:
    void start();
    void stop();
    void setInterval(int);

signals:
    void timeout();

private:
    QTimer* m_timer;
    int m_interval;
};



#endif // TIMER_H
