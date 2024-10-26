import QtQuick.Controls.Basic
import QtQuick
import QtQuick.Layouts
import films

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

        property int movieIndex : index

        width: cellWidth - 8
        height: cellHeight - 10
        border.color: "#2CDE85"
        radius: 4
        border.width: 2
        color: "#00414A"

        ColumnLayout {

            anchors.fill: parent
            spacing: 2

            Image {
                id: poster
                source: model.poster !== "N/A" ? model.poster : ""
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: implicitHeight / 2
                Layout.preferredWidth:  implicitWidth / 2

            }


            Text {
                id: title
                text: qsTr("%1 (%2)").arg(model.title).arg(model.year);
                color: "white"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.margins: 10
                elide: Text.ElideRight
            }
        }
    }
}
