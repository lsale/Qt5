#include <QQmlNdefFooRecord.h>
#include <Logger.h>
#include <QNdefRecord>
#include <QDebug>

QQmlNdefFooRecord::QQmlNdefFooRecord(QObject *parent){

}

//Our constructor will be called any time we tap an NFC tag
//We set our variables here
QQmlNdefFooRecord::QQmlNdefFooRecord(const QNdefRecord &record, QObject *parent){
    m_recordPayload = record.payload();
    m_recordType = record.type();
}
QQmlNdefFooRecord::~QQmlNdefFooRecord(){}

//Implementing our getters
QString QQmlNdefFooRecord::payload() const{
    return m_recordPayload;
}

QString QQmlNdefFooRecord::type() const{
    return m_recordType;
}

//Implementing our setters
void QQmlNdefFooRecord::setPayload(QString payload){
   Logger::print(this,"Value is: "+payload);
}

void QQmlNdefFooRecord::setType(QString type){
    Logger::print(this,"Value is: "+type);
}

Q_DECLARE_NDEFRECORD(QQmlNdefFooRecord, QNdefRecord::ExternalRtd, "my.bb.com:myrecordtype");
