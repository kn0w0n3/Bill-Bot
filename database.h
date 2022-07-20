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
    //Q_PROPERTY(QString rMessage READ getCurrentValues NOTIFY dbAmountDueToQml)

public:
    explicit Database(QObject *parent = nullptr);

signals:
    void sendMsgConfirmToQml2(QString);
    void dbBillNameToQml(QString billName_);
    void dbDueDateToQml(QString dueDate_);
    void dbNotifyDateToQml(QString notifyDate_);
    void dbAmountDueToQml(QString amountDue_);

public slots:
    void getInfoFromQmlForm(QString bName,QString dDate, QString dtNotify, QString aDue);
    void insertDatabaseInfo();
    void populateCurrentReminders();
    QString getCurrentValues();

private:
    QSqlDatabase *sqlitedb;
    //QStringList order;
    int columnCounter = 0;
    QSqlDatabase mydb;
    bool connected;
    //bool CreateConnection();

    //Variables to hold the incoming data from the form
    QString billName;
    QString dueDate;
    QString dateToNotify;
    QString amountDue;

    //Variables to hold the incoming data from the database
    QString pBillName;
    QString pDueDate;
    QString pDateToNotify;
    QString pAmountDue;
};

#endif // DATABASE_H
