#ifndef EMAILSENDCONTROLLER_H
#define EMAILSENDCONTROLLER_H
#include <QObject>
#include "smtp.h"
#include <QtWidgets/QMessageBox>
#include <QDebug>

class EmailSendController: public QObject{
     Q_OBJECT

public:
    explicit EmailSendController(QObject *parent = nullptr);

signals:
    void sendMsgConfirmToQml(QString);

public slots:
    void sendMail();

private slots:
    void mailSent(QString);

private:
    Smtp *smtp;

    //Sender email address
    QString uname = "someone@gmail.com";

    //Sender password. This must be a google generated app password.
    //https://support.google.com/accounts/answer/185833?hl=en
    QString paswd = "Enter your google app password here";

    //Gmail server info and port number below
    QString server = "smtp.gmail.com";
    int port = 465;

    //Recipient email address
    QString rcpt = "someone@gmail.com";

    //Subject and message for the email
    QString subject = "Test From Qt";
    QString msg  = "Hello this is a test from Qt.........";

};

#endif // EMAILSENDCONTROLLER_H
