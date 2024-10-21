import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import films

Window {
    id: root
    width: 960
    height: 480
    visible: true
    title: qsTr("Qt Movies")
    color: "black"

    ColumnLayout {
        anchors.fill: parent

        TextField {
            id: search
            Layout.preferredHeight: 100
            Layout.preferredWidth: 800
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            font.pixelSize: 80
            placeholderText: qsTr("Search movie...")

            Keys.onReturnPressed: MoviesManager.getMovies(text)

        }

        GridView {
            id: grid
            Layout.preferredWidth: 800
            Layout.preferredHeight: 400
            Layout.fillWidth: true
            Layout.margins: 10
            model: MoviesManager.movies
            cellWidth: 310
            cellHeight: 350
            clip: true

            add: Transition {
                NumberAnimation { properties: "x,y"; from: 100; duration: 1000 }
            }

            delegate: Rectangle {

                width: grid.cellWidth - 10
                height: grid.cellHeight - 10
                border.color: "#2CDE85"
                radius: 4
                border.width: 2
                anchors.margins: 10
                color: "#00414A"
                opacity: hoverHandler.hovered ? .8 : 1


                NumberAnimation on opacity {
                    from: 0
                    to: 1
                    duration: 300
                    easing.type: Easing.OutInQuad
                }

                HoverHandler {id: hoverHandler}


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
    }
}
