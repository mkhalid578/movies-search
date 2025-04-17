import QtQuick
import QtQuick.Controls.Basic

import films

ListView {
    id: notifications

    property alias notificationsModel: notifications.model

    enabled: false

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: 10

    width: 200
    height: 400

    z: Infinity
    spacing: 5

    verticalLayoutDirection: ListView.TopToBottom

    remove: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 300
        }
    }

    add: Transition {
        NumberAnimation {
            properties: "y"
            duration: 300
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 300
        }
    }



    model: ListModel {
        id: notificationModel
    }

    delegate: Rectangle {
        required property string name
        required property int index
        width: 200
        height: 50
        radius: 25
        color: "#323232"

        Text {
            text: name
            anchors.centerIn: parent
            color: "white"
            minimumPointSize: 10
            font.pointSize: 14
            fontSizeMode: Text.Fit
            elide: Text.ElideRight
        }

        Timer {
            interval: 2000; running: true;
            onTriggered: notificationModel.remove(index)
        }
    }

    Connections {
        target: MoviesManager
        function onMovieExistsAlready() {
            notificationsModel.insert(0, {name: "Title already exists"})
        }

        function onMovieAdded(title: string) {
            console.log("Added movie");
            notificationsModel.insert(0, {name: title});
        }
    }
}
