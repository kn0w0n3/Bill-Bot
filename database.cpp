#include "database.h"

Database::Database(QObject *parent) : QObject(parent){
    mydb = QSqlDatabase::addDatabase("QSQLITE");
    mydb.setDatabaseName("C:/pathToDB");

    if(!mydb.open()){
        qDebug() << "Constructor: Local Database Not Connected......";
    }
    else{
        qDebug() << "Constructor: Local Database is Connected.......";
        //insertOrderTimer = new QTimer();
        //connect(insertOrderTimer, SIGNAL(timeout()), this, SLOT(InsertTestOrders()));
        //insertOrderTimer->start(10000);
    }
}

void Database::getInfoFromQmlForm(QString bName, QString dDate, QString dtNotify, QString aDue){
    billName = bName;
    dueDate = dDate;
    dateToNotify = dtNotify;
    amountDue = aDue;

    qDebug() << billName;
    qDebug() << dueDate;
    qDebug() << dateToNotify;
    qDebug() << amountDue;
    insertDatabaseInfo();
}

void Database::insertDatabaseInfo(){
    if(!mydb.open()){
        qDebug() << "Order Creator Database Not Connected..........";
    }
    else{
        QSqlQuery query;
        query.exec("INSERT INTO bill_info_table (db_bill_name, db_due_date, db_date_to_notify, db_amount_due)" "VALUES (?, ?, ?, ?)");
        qDebug() << "Inserting info to database.......";
        query.bindValue(0, billName);
        query.bindValue(1, dueDate);
        query.bindValue(2, dateToNotify);
        query.bindValue(3, amountDue);
        query.exec();
    }
}

void Database::populateCurrentReminders(){

    QSqlQuery qry;
    qry.exec("SELECT db_bill_name, db_due_date, db_date_to_notify, db_amount_due FROM bill_info_table WHERE id > 0");
    qDebug() << "Pulling from database............";
    while(qry.next()){
        pBillName = qry.value(0).toString();
        emit dbBillNameToQml(pBillName);

        pDueDate = qry.value(1).toString();
        emit dbDueDateToQml(pDueDate);

        pDateToNotify = qry.value(2).toString();
        emit dbNotifyDateToQml(pDateToNotify);

        pAmountDue = qry.value(3).toString();
        emit dbAmountDueToQml(pAmountDue);

        //Update the database
        //QSqlQuery qry2;
        //qry2.exec("UPDATE bill_info_table SET order_status = 1 WHERE order_number ='"+orderNumber+"'");
        //qDebug() << "Updating Database.............";
    }
    // }
}

QString Database::getCurrentValues(){
    //return pBillName;
    //return pDueDate;
    //return pDateToNotify;
    return pAmountDue;
}
