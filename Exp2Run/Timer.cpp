#include <Timer.h>
#include <Logger.h>
#include <QObject>

Timer::Timer() : QObject() {
 m_timer = new QTimer();
 connect(m_timer, SIGNAL(timeout()), this, SIGNAL(timeout()));
 m_interval = 1000;
}

Timer::~Timer(){
    Logger::print(this, "Destroying Timer");
    delete m_timer;
}

void Timer::setInterval(int interval){
    Logger::print(this,"Changing the interval to "+interval);
    if(!isActive()){
        m_interval = interval;
    }
}

bool Timer::isActive(){
    return m_timer->isActive();
}

void Timer::start(){
    Logger::print(this, "Starting the timer");
    if(!isActive())
        m_timer->start(m_interval);
}

void Timer::stop(){
    Logger::print(this,"Stopping the timer");
    m_timer->stop();
}


