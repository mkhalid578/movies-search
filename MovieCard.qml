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

        Image {
            id: poster
            source: root.poster !== "N/A" ? root.poster : "assets/image.svg"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 200
            Layout.preferredWidth:  150

        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            CardButton {
                cardIcon: "assets/info.svg"
                onClicked: infoPressed()
            }

            CardButton {
                cardIcon: "assets/add.svg"
                onPressed: addPressed()
            }

        }

        Text {
            id: title
            text: qsTr("%1 (%2)").arg(root.title).arg(root.year);
            color: "black"
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.margins: 10
            elide: Text.ElideRight
        }
    }
}
