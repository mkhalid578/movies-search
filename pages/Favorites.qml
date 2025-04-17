import QtQuick.Controls.Basic
import QtQuick
import QtQuick.Layouts
import films

ColumnLayout {

    anchors.fill: parent

    GridView {
        id: grid

        model: MoviesManager.favorites
        width: 960
        height: 640
        cellWidth: 320
        cellHeight: 350
        clip: true

        InfoModal {
            id: info
            anchors.centerIn: parent
        }


        add: Transition {
            NumberAnimation { properties: "opacity"; from: 0; to: 1.0; duration: 500 }
        }

        populate: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 350 }
        }

        remove: Transition {
            NumberAnimation { property: "opacity"; to: 0; duration: 500 }
        }

        delegate: Rectangle {

            id: card
            property int movieIndex : index
            property bool flipped: false

            width: grid.cellWidth - 8
            height: grid.cellHeight - 10
            border.color: "#dcdcdc"
            radius: 4
            border.width: 2
            color: "#f4f4f4"

            HoverHandler {
                id: hoverHandler
            }

            scale: hoverHandler.hovered ? 1.07 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 120; easing.type: Easing.InOutQuad
                }
            }


            ColumnLayout {

                anchors.fill: parent
                spacing: 2

                Image {
                    id: poster
                    source: model.poster !== "N/A" ? model.poster : "qrc:/assets/image.svg"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: implicitHeight / 2
                    Layout.preferredWidth:  implicitWidth / 2

                }


                Text {
                    id: title
                    text: qsTr("%1 (%2)").arg(model.title).arg(model.year);
                    color: "black"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.margins: 10
                    elide: Text.ElideRight
                }
            }
        }
    }
}
