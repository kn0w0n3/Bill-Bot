import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Bill Bot")


    //Timer to update the clock text
    Rectangle {
        id: settings
        width: 640
        height: 480
        color: "#ffffff"
        Component.onCompleted:{
            database.populateSvdEmailBox()
            database.getFirstDatabaseEntries()
        }



        Image {
            id: image
            x: 0
            y: 0
            width: 640
            height: 480
            fillMode: Image.PreserveAspectFit
            source: "images/abstract_colorful_bg_2.png"

            Rectangle {
                id: savedEmailBoxBg
                x: 347
                y: 130
                width: 272
                height: 145
                color: "#ffffff"
            }
        }

        Text {
            id: element4
            x: 402
            y: 103
            width: 163
            height: 24
            text: qsTr("Saved Email Addresses")
            font.underline: true
            font.bold: false
            font.pixelSize: 16
        }

        Button {
            id: settingsBackButton
            x: 4
            y: 5
            width: 65
            height: 25
            text: qsTr("Back")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }
            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }
            onClicked: {
                settings.visible = false
                mainMenu.visible = true
            }
        }

        Image {
            id: borderImage1
            x: 293
            y: 2
            width: 380
            height: 396
            fillMode: Image.PreserveAspectFit
            source: "images/scroll_border_black_thinner.png"
        }

        Button {
            id: deleteSavedEmailButton
            x: 453
            y: 293
            width: 60
            height: 20
            text: qsTr("Delete")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }
            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }
            onClicked: {
                //reminderEmailModel.remove(0)
            }
        }

        Rectangle {
            id: billNameTxtRect5
            x: 51
            y: 145
            width: 200
            height: 16
            color: "#ffffff"
            TextEdit {
                id: senderEmailTxtEdit
                x: 3
                y: 0
                width: 192
                height: 16
                text: qsTr("")
                cursorVisible: false
                selectByMouse: true
                clip: true
                wrapMode: Text.NoWrap
                font.pixelSize: 12
            }
            border.color: "#000000"
        }

        Rectangle {
            id: billNameTxtRect6
            x: 51
            y: 183
            width: 200
            height: 16
            color: "#ffffff"
            TextEdit {
                id: sndrEmailPwdTxtEdit
                x: 3
                y: 0
                width: 192
                height: 16
                text: qsTr("")
                cursorVisible: false
                selectByMouse: true
                clip: true
                wrapMode: Text.NoWrap
                font.pixelSize: 12
            }
            border.color: "#000000"
        }

        Button {
            id: saveEmailInfoButton
            x: 78
            y: 213
            width: 60
            height: 20
            text: qsTr("Add")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }

            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }

            onClicked: {
                //Send the user entered email info to the C++ Database class to be inserted into the database
                database.receiveEmailInfoFromQML(senderEmailTxtEdit.text, sndrEmailPwdTxtEdit.text)

                //Clear the text box
                senderEmailTxtEdit.text = ""
                sndrEmailPwdTxtEdit.text = ""
            }
        }
        Button {
            id: clearEmailInfoButton
            x: 158
            y: 213
            width: 60
            height: 20
            text: qsTr("Clear")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }
            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }
        }
        Text {
            id: element3
            x: 53
            y: 168
            width: 130
            height: 14
            text: qsTr("Sender Email Password")
            font.pixelSize: 12
        }
        Text {
            id: element2
            x: 53
            y: 130
            width: 122
            height: 14
            text: qsTr("Sender Email Address")
            font.pixelSize: 12
        }
        Text {
            id: element1
            x: 70
            y: 100
            width: 159
            height: 24
            text: qsTr("Add Sender Email Info")
            font.underline: true
            font.bold: false
            font.pixelSize: 16
        }

        ListView{
            id: savedEmailListVew
            x: 351
            y: 133
            width: 264
            height: 138
            clip: true
            orientation: ListView.Vertical
            highlightFollowsCurrentItem: false
            //headerPositioning: savedEmailListVew.OverlayHeader
            model: ListModel {
                id:reminderEmailModel
                ListElement {

                    someText: "someText"
                    //anchors.centerIn: parent

                }
            }

            //Populating the list model dynaically is haveing some issues. Janky workaround is to just remove the duplicate first entry.
            delegate: Label{

                id: iEmailLabel
                width: 451
                height: 25

                Text {
                    id:iEMailText

                    text: someText
                    font.bold: false
                    anchors.verticalCenter: parent.verticalCenter
                    Connections {
                        target: database

                        onFEmailToQml: {
                            iEMailText.text = fEmail_
                            reminderEmailModel.append({"someText": fEmail_})
                        }
                        onFEmailToQmlDone: {
                            reminderEmailModel.remove(0)
                        }

                    }

                }
            }


        }


        //Timer to update the date text

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

        /*
                Component.onCompleted: {
                    for (var i = 0; i < 1; i++) {
                        reminderModel1.append(createListElement());
                    }
                }

                function createListElement() {
                    //console.log(i)
                    //console.log("Something Happened")
                    console.log("Something Happened")

                    return {
                        someText: "i"
                    };
                }
                //ListElement {
                //_savedEmail: "fEmail_"
                //}
            }
            */

    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        onTriggered:{
            currentTimeText.text =  Qt.formatTime(new Date(),"hh:mm:ss")
        }
    }

    Rectangle {
        id: addItemScreen
        width: 640
        height: 480
        color: "#ffffff"
        Component.onCompleted:
            database.populateCurrentReminders()


        Image {
            id: background
            width: 640
            height: 480
            fillMode: Image.PreserveAspectFit
            source: "images/abstract_colorful_bg_2.png"

            Button {
                id: saveNewBillReminder
                x: 299
                y: 303
                width: 75
                height: 25
                text: qsTr("Save")
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: "#aa000000"
                    radius: 8
                    samples: 17
                    horizontalOffset: 4
                    verticalOffset: 4
                    spread: 0
                }
                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#000000"
                    radius: 50
                }

                onClicked: {
                    //Run the c++ function to grab the data from here
                    database.receiveBillInfoFromQML(billNameTxtEdit.text, dueDateTextEdit.text, notifyDatextEdit.text, amountDueTxtEdit.text)

                }
            }

            Button {
                id: clearBtnNewBillReminder
                x: 401
                y: 303
                width: 75
                height: 25
                text: qsTr("Clear")
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: "#aa000000"
                    radius: 8
                    samples: 17
                    horizontalOffset: 4
                    verticalOffset: 4
                    spread: 0
                }
                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#000000"
                    radius: 50
                }
            }

            Button {
                id: backBtnNewBillReminder
                x: 8
                y: 13
                width: 65
                height: 25
                text: qsTr("Back")
                flat: false
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: "#aa000000"
                    radius: 8
                    samples: 17
                    horizontalOffset: 4
                    verticalOffset: 4
                    spread: 0
                }
                background: Rectangle {
                    color: "#ffffff"
                    border.color: "#000000"
                    radius: 50
                }
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
            width: 225
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: dueDateTextEdit
                x: 3
                y: -1
                width: 214
                height: 17
                clip: true
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: billNameTxtRect3
            x: 277
            y: 232
            width: 225
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: notifyDatextEdit
                x: 3
                y: 0
                width: 214
                height: 16
                clip: true
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: billNameTxtRect4
            x: 277
            y: 258
            width: 225
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: amountDueTxtEdit
                x: 3
                y: 0
                width: 214
                height: 16
                clip: true
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: billNameTxtRect1
            x: 278
            y: 177
            width: 224
            height: 16
            color: "#ffffff"
            border.color: "black"

            TextEdit {
                id: billNameTxtEdit
                x: 3
                y: 0
                width: 213
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
            x: 329
            y: 136
            width: 122
            height: 25
            color: "#000000"
            text: qsTr("Enter Bill Info")
            font.underline: true
            font.bold: false
            font.pixelSize: 18
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
                x: 554
                y: 8
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

            Rectangle {
                id: reminderWinBg
                x: 91
                y: 126
                width: 459
                height: 243
                color: "#ffffff"
            }
        }

        Button {
            id: addReminderButton
            x: 93
            y: 410
            width: 90
            height: 20
            text: qsTr("Add Reminder")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }
            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }
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
            id: deleteReminderButton
            x: 271
            y: 410
            width: 99
            height: 20
            text: qsTr("Delete Reminder")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }
            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }
        }

        Text {
            id: currentRemindersText
            x: 251
            y: 64
            width: 167
            height: 22
            color: "#000000"
            text: qsTr("Current Reminders")
            font.underline: true
            font.bold: false
            font.pixelSize: 19
        }

        Button {
            id: settingsButton
            x: 451
            y: 410
            width: 99
            height: 20
            text: qsTr("Settings")
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#aa000000"
                radius: 8
                samples: 17
                horizontalOffset: 4
                verticalOffset: 4
                spread: 0
            }

            background: Rectangle {
                color: "#ffffff"
                border.color: "#000000"
                radius: 50
            }

            onClicked: {
                mainMenu.visible = false
                addItemScreen.visible = false
                settings.visible = true
            }
        }

        Text {
            id: element5
            x: 112
            y: 109
            width: 52
            height: 14
            text: qsTr("Bill Name")
            font.pixelSize: 12
        }

        Text {
            id: element6
            x: 217
            y: 109
            height: 14
            text: qsTr("Due Date")
            font.pixelSize: 12
        }

        Text {
            id: element7
            x: 295
            y: 109
            width: 79
            height: 14
            text: qsTr("Reminder Date")
            font.pixelSize: 12
        }

        Text {
            id: element8
            x: 389
            y: 110
            width: 69
            height: 14
            text: qsTr("Amount Due")
            font.pixelSize: 12
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

        ListView {
            id: listView
            x: 95
            y: 129
            width: 451
            height: 238
            clip: true
            highlightFollowsCurrentItem: false

            model: ListModel {
                id:reminderModel
                ListElement {
                    // _billName: ""
                    // _dueDate: ""
                    // _dateToNotify: ""
                    //_amountDue: ""
                    listEntry: ""

                }
            }

            delegate: Label{
                id: iremindLabelText
                width: 451
                height: 25
                Text {
                    id:reminderText
                    //text: _billName + "   |   " + _dueDate + "    |   " + _dateToNotify + "    |   " + _amountDue
                    text: listEntry
                    font.bold: false
                    anchors.verticalCenter: parent.verticalCenter
                    Connections {
                        target: database

                        onDbBillNameToQml: {
                            reminderText.text = billName_
                            //reminderModel.append({"_billName": reminderText.text})
                        }
                        onDbDueDateToQml: {
                            reminderText.text +=  dueDate_
                            // reminderModel.append({"_dueDate":  reminderText.text += dueDate_ + "     |      "})
                        }
                        onDbNotifyDateToQml:{

                            reminderText.text += notifyDate_
                            //reminderModel.append({"_dateToNotify":  reminderText.text += notifyDate_ + "     |   "})
                        }
                        onDbAmountDueToQml:{
                            reminderText.text += amountDue_
                            reminderModel.append({"listEntry": reminderText.text})
                        }
                        onFBillToQmlDone:{
                            reminderModel.remove(0)
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:1;invisible:true}D{i:33;invisible:true}
}
##^##*/
