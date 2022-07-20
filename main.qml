import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Bill Bot")

    //Timer to update the clock text

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        onTriggered:
        {
            currentTimeText.text =  Qt.formatTime(new Date(),"hh:mm:ss")
        }
    }
    //Timer tto update the date text
    Rectangle {
        id: addItemScreen
        width: 640
        height: 480
        color: "#ffffff"
        Component.onCompleted: database.populateCurrentReminders()

        Image {
            id: background
            width: 640
            height: 480
            fillMode: Image.PreserveAspectFit
            source: "images/abstract_colorful_bg_2.png"


            Button {
                id: saveNewBillReminder
                x: 272
                y: 308
                width: 75
                height: 25
                text: qsTr("Save")

                onClicked: {
                    //Run the c++ function to grab the data from here
                    database.getInfoFromQmlForm(billNameTxtEdit.text, dueDateTextEdit.text, notifyDatextEdit.text, amountDueTxtEdit.text)

                }
            }

            Button {
                id: button3
                x: 374
                y: 308
                width: 75
                height: 25
                text: qsTr("Clear")
            }

            Button {
                id: button4
                x: 8
                y: 13
                width: 65
                height: 25
                text: qsTr("Back")
                onClicked: {
                    mainMenu.visible = true
                    addItemScreen.visible = false
                    /*
                    if(weather.visible == true){
                        weather.visible = false
                    }
                    if(information.visible == true){
                        information.visible = false
                    }
                    if(camera.visible == true){
                        camera.visible = false
                    }
                    if(lights.visible == true){
                        lights.visible = false
                    }
                    if(sprinkler.visible == true){
                        sprinkler.visible = false
                    }
                    */
                }
            }


        }

        Text {
            id: billNameLabel
            x: 204
            y: 176
            width: 63
            height: 24
            color: "#000000"
            text: qsTr("Bill Name:")
            font.bold: false
            font.pixelSize: 14
        }
        Text {
            id: dueDateLabel
            x: 203
            y: 204
            width: 63
            height: 24
            color: "#000000"
            text: qsTr("Due Date:")
            font.bold: false
            font.pixelSize: 14
        }
        Text {
            id: notifyLabel
            x: 157
            y: 231
            width: 111
            height: 24
            color: "#000000"
            text: qsTr("Notification Date:")
            font.bold: false
            font.pixelSize: 14
        }
        Text {
            id: amountDueLabel
            x: 180
            y: 256
            width: 84
            height: 24
            color: "#000000"
            text: qsTr("Amount Due:")
            font.bold: false
            font.pixelSize: 14
        }

        Rectangle {
            id: billNameTxtRect2
            x: 277
            y: 205
            width: 165
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: dueDateTextEdit
                x: 0
                y: -1
                width: 162
                height: 17
                clip: true
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: billNameTxtRect3
            x: 277
            y: 232
            width: 165
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: notifyDatextEdit
                x: 0
                y: 0
                width: 162
                height: 16
                clip: true
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: billNameTxtRect4
            x: 277
            y: 258
            width: 165
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: amountDueTxtEdit
                x: 0
                y: 0
                width: 162
                height: 16
                clip: true
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: billNameTxtRect1
            x: 278
            y: 177
            width: 165
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: billNameTxtEdit
                x: 0
                y: 0
                width: 162
                height: 16
                text: qsTr("")
                selectByMouse: true
                clip: true
                wrapMode: Text.NoWrap
                font.pixelSize: 12

            }
        }

        Text {
            id: element
            x: 299
            y: 137
            width: 122
            height: 25
            color: "#000000"
            text: qsTr("Enter Bill Info")
            font.underline: true
            font.bold: false
            font.pixelSize: 18
        }




    }

    Timer {
        id: dateTimer
        interval: 1000
        repeat: true
        running: true
        property var locale: Qt.locale()
        property date currentDate: new Date()
        property string dateString
        onTriggered:{
            currentDateText.text = currentDate.toLocaleDateString(locale, Locale.ShortFormat);
        }
    }



    Rectangle {
        id: mainMenu
        width: 640
        height: 480
        color: "#ffffff"

        Image {
            id: bgImage
            x: 0
            y: 0
            width: 640
            height: 480
            source: "images/abstract_colorful_bg_2.png"
            fillMode: Image.PreserveAspectFit

            Text {
                id: currentTimeText
                x: 558
                y: 6
                width: 67
                height: 21
                color: "#000000"
                text: "18:33:42"
                font.bold: false
                font.pixelSize: 14

            }

            Text {
                id: currentDateText
                x: 550
                y: 33
                width: 83
                height: 22
                color: "#000000"
                text: "7/15/2022"
                font.pixelSize: 14
                font.bold: false
            }

        }


        Button {
            id: button
            x: 182
            y: 418
            width: 90
            height: 20
            text: qsTr("Add Reminder")
            onClicked: {
                mainMenu.visible = false
                addItemScreen.visible = true
                /*
                if(weather.visible == true){
                    weather.visible = false
                }
                if(information.visible == true){
                    information.visible = false
                }
                if(camera.visible == true){
                    camera.visible = false
                }
                if(lights.visible == true){
                    lights.visible = false
                }
                if(sprinkler.visible == true){
                    sprinkler.visible = false
                }
                */
            }
        }

        Button {
            id: button1
            x: 354
            y: 418
            width: 99
            height: 20
            text: qsTr("Delete Reminder")
        }

        Text {
            id: currentRemindersText
            x: 238
            y: 95
            width: 167
            height: 22
            color: "#000000"
            text: qsTr("Current Reminders")
            font.underline: true
            font.bold: false
            font.pixelSize: 19
        }

        Image {
            id: borderImage
            x: 0
            y: 2
            width: 640
            height: 480
            fillMode: Image.PreserveAspectFit
            source: "images/scroll_border_black_thinner.png"
        }

        ScrollView {
            id: scrollView
            x: 93
            y: 129
            width: 457
            height: 235
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn



            ListView {
                id: listView
                x: 92
                y: 123
                width: 451
                height: 199

                model: ListModel {

                    id:reminderModel
                    ListElement {
                        _billName: ""
                        _dueDate: ""
                        _dateToNotify: ""
                        _amountDue: ""
                    }
                }

                ItemDelegate {
                    x: 5
                    width: 80
                    height: 40
                    Row {
                        id: row1
                        spacing: 10
                        //Rectangle {
                        //width: 40
                        // height: 40
                        //color: colorCode
                        //}

                        Text {
                            id:reminderText
                            //text: _billName + "   |   " + _dueDate + "   |   " + _dateToNotify + "   |   " + _amountDue
                            text: ""
                            font.bold: false
                            anchors.verticalCenter: parent.verticalCenter
                            Connections {
                                target: database

                                onDbBillNameToQml: {

                                    reminderText.text += billName_ + "   |   "
                                    //reminderModel.append({"_billName": billName_})
                                }
                                onDbDueDateToQml: {
                                    reminderText.text += dueDate_ + "   |   "
                                    //reminderModel.append({"_dueDate": dueDate_})
                                }

                                onDbNotifyDateToQml:{
                                    reminderText.text += notifyDate_ + "   |   "
                                    //reminderModel.append({"_dateToNotify": notifyDate_})
                                }

                                onDbAmountDueToQml:{

                                    //TODO FIX THIS COMMUNICATION



                                    reminderText.text += amountDue_
                                    // reminderModel.append({"_amountDue": amountDue_})
                                    //reminderText.text = billName_ + "   |   " + dueDate_ + "   |   " + notifyDate_ + "   |   " + amountDue_
                                    //reminderText.text = "Hello " + amountDue_
                                    //text: _billName + "   |   " + _dueDate + "   |   " + _dateToNotify + "   |   " + _amountDue
                                    //_billName.text = billName_
                                    //_dueDate.text = dueDate_
                                    //_dateToNotify.text = notifyDate_
                                    //_amountDue.text = amountDue_
                                    //xxxxxx.text =  "   |   " +  "   |   " + "   |   " + _amountDue
                                    //text: _billName + "   |   " + _dueDate + "   |   " + _dateToNotify + "   |   " + _amountDue
                                    //reminderModel.append({_billName: billName_, _dueDate: dueDate_, _dateToNotify: notifyDate_, _amountDue: amountDue_})
                                    //reminderModel.append(reminderText.text)// This is available in all editors



                                }
                            }
                        }
                    }
                }
            }

            /*
            ItemDelegate {
                id: itemDelegate
                text: qsTr("<font color=\"white\";font-size=\"16px\">Bank of America | Due: 7/15/22 | $229.00</font>")
                font.pixelSize: 15
                font.bold: true
                //color: "#ffffff"
            }
            */

        }
    }
}



/*##^##
Designer {
    D{i:2;invisible:true}
}
##^##*/
