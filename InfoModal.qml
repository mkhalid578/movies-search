import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Effects

Popup {
    id: popup
    x: 100
    y: 100
    width: 600
    height: 500
    modal: true
    focus: true

    property string description: ""
    property string title: ""
    property string poster: ""
    property string actors: ""
    property string totalRunTime: ""
    property string director: ""

    onAboutToShow: {
        descriptionField.text = description
    }

    contentItem: Rectangle {
        anchors.fill: parent
        color: "#373F26"


        Button {
            id: close
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 5
            anchors.rightMargin: 5
            icon.source: "assets/close.svg"
            icon.color: "#DBEB00"
            background: Item {}
            onClicked: popup.close()
        }

        ColumnLayout {
            anchors.fill: parent

            Text {
                id: mainTitle
                text: popup.title
                font.pixelSize: 30
                color: "#DBEB00"
                Layout.preferredWidth: 400
                wrapMode: Text.WordWrap
                Layout.margins: 10
            }

            RowLayout {

                Layout.preferredWidth: 450
                Layout.alignment: Qt.AlignHCenter
                spacing: 5

                Image {
                    source: poster !== "N/A" ? poster : ""
                    Layout.preferredHeight: sourceSize.height * .8
                    Layout.preferredWidth: sourceSize.width * .8
                }

                ColumnLayout {

                    Layout.fillWidth: true

                    Text {
                        id: directorsField
                        text: qsTr("<b>Directed by:</b>: %1").arg(director)
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        wrapMode: Text.WordWrap
                        color: "#DBEB00"
                        Layout.margins: 5
                    }


                    Text {
                        id: actorsField
                        text: qsTr("<b>Starring</b>: %1").arg(actors)
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        wrapMode: Text.WordWrap
                        color: "#DBEB00"
                        Layout.margins: 5
                    }

                    Text {
                        id: descriptionField
                        text: qsTr("<b>Plot</b>: %1").arg(description)
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        wrapMode: Text.WordWrap
                        color: "#DBEB00"
                        Layout.margins: 5
                    }
                    Text {
                        id: runtime
                        text: qsTr("<b>Total Runtime</b>: %1").arg(totalRunTime)
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 300
                        wrapMode: Text.WordWrap
                        color: "#DBEB00"
                        Layout.margins: 5
                    }

                }



            }


        }
    }

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
}
