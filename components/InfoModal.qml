import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Effects

Popup {
    id: popup
    x: 100
    y: 100
    width: 600
    height: 400
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

    opacity: visible ? 1: 0
    scale: visible ? 1 : 0.9

    Behavior on opacity {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }

    }

    background: Rectangle {
        color: "#ffffff"
        radius: 12
        border.color: "#e0e0e0"
        border.width: 1
    }

    contentItem: ColumnLayout {

        anchors.fill: parent

        RowLayout {

            Layout.fillWidth: true

            Text {
                id: mainTitle
                text: popup.title
                font.pixelSize: 30
                color: "black"
                Layout.preferredWidth: 520
                wrapMode: Text.WordWrap
                Layout.margins: 10
                Layout.alignment: Qt.AlignCenter
            }

            Button {
                id: close
                Layout.alignment: Qt.AlignRight
                icon.source: "qrc:/assets/close.svg"
                icon.color: "black"
                background: Rectangle {
                    radius: 12
                    color: "#dcdcdc"
                }

                onClicked: popup.close()

                scale: down ? 0.96 : (hovered ? 1.07 : 1.0)

                Behavior on scale {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutQuad
                    }
                }
            }

        }


        RowLayout {

            Layout.preferredWidth: 450
            Layout.alignment: Qt.AlignHCenter
            spacing: 8

            Image {
                source: poster !== "N/A" ? poster : ""
                Layout.preferredHeight: sourceSize.height * .6
                Layout.preferredWidth: sourceSize.width * .6
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
                    color: "black"
                    Layout.margins: 5
                }


                Text {
                    id: actorsField
                    text: qsTr("<b>Starring</b>: %1").arg(actors)
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 300
                    wrapMode: Text.WordWrap
                    color: "black"
                    Layout.margins: 5
                }

                Text {
                    id: descriptionField
                    text: qsTr("<b>Plot</b>: %1").arg(description)
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 300
                    wrapMode: Text.WordWrap
                    color: "black"
                    Layout.margins: 5
                }
                Text {
                    id: runtime
                    text: qsTr("<b>Total Runtime</b>: %1").arg(totalRunTime)
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 300
                    wrapMode: Text.WordWrap
                    color: "black"
                    Layout.margins: 5
                }

            }
        }
    }

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
}
