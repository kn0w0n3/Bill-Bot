#ifndef DATABASE_H
#define DATABASE_H
#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QtSql>
#include <QSqlDatabase>
#include <QDebug>

class Database: public QObject{
    Q_OBJECT

public:
    explicit Database(QObject *parent = nullptr);

signals:
    void sendMsgConfirmToQml2(QString);
    void dbBillNameToQml(QString billName_);
    void dbDueDateToQml(QString dueDate_);
    void dbNotifyDateToQml(QString notifyDate_);
    void dbAmountDueToQml(QString amountDue_);

public slots:
    void receiveBillInfoFromQML(QString bName,QString dDate, QString dtNotify, QString aDue);
    void insertBillDbInfo();
    void receiveEmailInfoFromQML(QString uName, QString pWord);
    void insertEmailToDb();
    void populateCurrentReminders();    

private:
    //Connections for working with different tables simultaneously.
    QSqlDatabase billDB;
    QSqlDatabase sEmailDB;
    QSqlDatabase rEmailDB;
    QSqlDatabase populateDB;

    //Variables to hold the incoming data from the reminder form.
    QString billName;
    QString dueDate;
    QString dateToNotify;
    QString amountDue;

    //Variables to hold the incoming data from the database.
    QString pBillName;
    QString pDueDate;
    QString pDateToNotify;
    QString pAmountDue;

    //Variables to hold the incoming data for the email address to save to the database.
    QString iUsername;
    QString iPassword;
    QString iServer = "smtp.gmail.com";
    QString iPortNumber = "465";
};

#endif // DATABASE_H
