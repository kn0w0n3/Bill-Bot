#include "database.h"

Database::Database(QObject *parent) : QObject(parent){
    //Multiple connections were required to work with the different tables simultaneously.
    //Format for the query: QSqlQuery query(QSqlDatabase::database("conn2-BillInfo"));
    sEmailDB = QSqlDatabase::addDatabase("QSQLITE", "conn1_EmailInfo");
    sEmailDB.setDatabaseName("C:/ENTER_YOUR_PATH_TO/bill_info.db");

    billDB = QSqlDatabase::addDatabase("QSQLITE", "conn2-BillInfo");
    billDB.setDatabaseName("C:/ENTER_YOUR_PATH_TO/bill_info.db");

    populateDB = QSqlDatabase::addDatabase("QSQLITE", "conn3-popCReminders_");
    populateDB.setDatabaseName("C:/ENTER_YOUR_PATH_TO/bill_info.db");

    //For now, do an initial check to see if the connections are working.
    if(!sEmailDB.open()){
        qDebug() << "Constructor:  Email Database Not Connected......";
    }
    else{
        qDebug() << "Constructor:  Email Database is Connected.......";
    }

    if(!billDB.open()){
        qDebug() << "Constructor: billDB Not Connected......";
    }
    else{
        qDebug() << "Constructor: billDB is Connected.......";
    }
    if(!rEmailDB.open()){
        qDebug() << "Constructor: rEmailDB Not Connected......";
    }
    else{
        qDebug() << "Constructor: rEmailDB is Connected.......";
    }
}

//Receive and store bill information from the QML form
void Database::receiveBillInfoFromQML(QString bName, QString dDate, QString dtNotify, QString aDue){
    billName = bName;
    dueDate = dDate;
    dateToNotify = dtNotify;
    amountDue = aDue;
    insertBillDbInfo();
}

//Insert sender email info to the database.
void Database::insertEmailToDb(){
    if(!sEmailDB.open()){
        qDebug() << "Function: Local Email Database Not Connected......";
    }
    else{
        qDebug() << "Function: Local Email Info Database is Connected.......";
        QSqlQuery insertEmailQuery(QSqlDatabase::database("conn1_EmailInfo"));
        insertEmailQuery.exec("INSERT INTO sender_email_info (username, password, server, port_number) " "VALUES (?, ?, ?, ?)");

        qDebug() << "Trying to insert email info to database.......";
        insertEmailQuery.bindValue(0, iUsername);
        insertEmailQuery.bindValue(1, iPassword);
        insertEmailQuery.bindValue(2, iServer);
        insertEmailQuery.bindValue(3, iPortNumber);
        insertEmailQuery.exec();
    }
}

//Insert reminder form info into the database.
void Database::insertBillDbInfo(){
    if(!billDB.open()){
        qDebug() << "Database Not Connected..........";
    }
    else{
        QSqlQuery query(QSqlDatabase::database("conn2-BillInfo"));
        query.exec("INSERT INTO bill_info_table (db_bill_name, db_due_date, db_date_to_notify, db_amount_due)" "VALUES (?, ?, ?, ?)");
        qDebug() << "Inserting info to database.......";
        query.bindValue(0, billName);
        query.bindValue(1, dueDate);
        query.bindValue(2, dateToNotify);
        query.bindValue(3, amountDue);
        query.exec();
    }
}

//Get the current saved reminders from the database and populate the main menu QML form.
void Database::populateCurrentReminders(){
    QSqlQuery popCReminders(QSqlDatabase::database("conn3-popCReminders_"));
    popCReminders.exec("SELECT db_bill_name, db_due_date, db_date_to_notify, db_amount_due FROM bill_info_table WHERE id > 0");
    qDebug() << "Pulling from database to populate current reminders............";
    while(popCReminders.next()){
        pBillName = popCReminders.value(0).toString();
        emit dbBillNameToQml(pBillName);

        pDueDate = popCReminders.value(1).toString();
        emit dbDueDateToQml(pDueDate);

        pDateToNotify = popCReminders.value(2).toString();
        emit dbNotifyDateToQml(pDateToNotify);

        pAmountDue = popCReminders.value(3).toString();
        emit dbAmountDueToQml(pAmountDue);
    }
}

//Receive and store data from the QML settings form. This is a sending email address that the user wants to save. Only Gmail is working for now.
void Database::receiveEmailInfoFromQML(QString uName, QString pWord){
    if(uName.isEmpty()){
        return;
        qDebug() << "Empty string in receiveEmailInfoToSave() function";
    }
    iUsername = uName;
    iPassword = pWord;

    qDebug() << iUsername;
    qDebug() << iPassword;
    qDebug() << iServer;
    qDebug() << iPortNumber;
    insertEmailToDb();
}

