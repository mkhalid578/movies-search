import QtQuick
import QtQuick.Layouts
import films

Rectangle {

    id: root

    property int movieIndex
    property string poster
    property string title
    property string year
    property string movieId

    signal infoPressed()
    signal addPressed()


    color: "#f4f4f4"
    radius: 12
    border.color: "#dcdcdc"
    border.width: 1

    scale: hoverHandler.hovered ? 1.02 : 1.0

    Behavior on scale {
        NumberAnimation {
            duration: 120; easing.type: Easing.OutQuad
        }
    }

    HoverHandler {id: hoverHandler}


    ColumnLayout {

        anchors.fill: parent
        spacing: 2

        Text {
            id: title
            color: "black"
            text: root.title
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 280
            elide: Text.ElideRight
            Layout.margins: 8
        }

        Image {
            id: poster
            source: root.poster !== "N/A" ? root.poster : "qrc:/assets/image.svg"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 200
            Layout.preferredWidth:  150

        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 8

            CardButton {
                cardIcon: "qrc:/assets/info.svg"
                onClicked: infoPressed()
            }

            CardButton {
                cardIcon: "qrc:/assets/add.svg"
                onPressed: addPressed()
            }
            CardButton {
                cardIcon: "qrc:/assets/heart.svg"
            }

        }


    }
}
