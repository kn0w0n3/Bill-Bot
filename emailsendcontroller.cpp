#include "emailsendcontroller.h"

EmailSendController::EmailSendController(QObject *parent) : QObject(parent){

}

void EmailSendController::sendMail(){
    smtp = new Smtp(uname, paswd, server, port);
    connect(smtp, SIGNAL(status(QString)), this, SLOT(mailSent(QString)));
    smtp->sendMailS(uname, rcpt, subject, msg);
}

void EmailSendController::mailSent(QString status){
    if(status == "Message sent"){
        qDebug() << "Sent";
    }
}
