#include "emailsendcontroller.h"

EmailSendController::EmailSendController(QObject *parent) : QObject(parent){
    //connect(ui->sendBtn, SIGNAL(clicked()),this, SLOT(sendMail()));
    //connect(ui->exitBtn, SIGNAL(clicked()),this, SLOT(close()));
}

void EmailSendController::sendMail(){
    Smtp *smtp = new Smtp(uname,paswd,server,port.toInt());
    connect(smtp, SIGNAL(status(QString)), this, SLOT(mailSent(QString)));
    smtp->sendMail(uname, rcpt, subject, msg);
}

void EmailSendController::mailSent(QString status){
    if(status == "Message sent"){
        qDebug() << "Sent";
    }
       //QMessageBox::warning(0, tr("Qt Simple SMTP client"), tr("Message sent!\n\n" ));
}
