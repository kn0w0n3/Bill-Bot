#ifndef EMAILSENDCONTROLLER_H
#define EMAILSENDCONTROLLER_H
#include <QObject>
#include "smtp.h"
#include <QtWidgets/QMessageBox>
#include <QDebug>

class EmailSendController: public QObject
{
     Q_OBJECT

    Q_PROPERTY(QString rMessage NOTIFY sendMsgConfirmToQml)
public:
    explicit EmailSendController(QObject *parent = nullptr);

     //The destructor gave a MOC error
     //~EmailSendController();
signals:
    void sendMsgConfirmToQml(QString);

private slots:
    void sendMail();
    void mailSent(QString);

private:
    QString name;
    QString uname;
    QString paswd;
    QString server;
    QString port;
    QString rcpt;
    QString subject;
    QString msg;
};

#endif // EMAILSENDCONTROLLER_H
