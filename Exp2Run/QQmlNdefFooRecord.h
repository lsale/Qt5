#ifndef QQMLNDEFFOORECORD_H
#define QQMLNDEFFOORECORD_H
#include <QQmlNdefRecord>
#include <QNdefRecord>
#include <QObject>

class QQmlNdefFooRecord : public QQmlNdefRecord
{
    Q_OBJECT

    Q_PROPERTY(QString payload READ payload WRITE setPayload NOTIFY payloadChanged)
    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)

public:
    explicit QQmlNdefFooRecord(QObject *parent = 0);
    Q_INVOKABLE QQmlNdefFooRecord(const QNdefRecord &record, QObject *parent = 0);
    ~QQmlNdefFooRecord();

    QString payload() const;
    QString type() const;

    void setPayload(QString payload);
    void setType(QString type);

signals:
    void payloadChanged();
    void typeChanged();

private:
    QString m_recordPayload;
    QString m_recordType;
};
#endif // QQMLNDEFFOORECORD_H
