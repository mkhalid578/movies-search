import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import films


GridView {
    id: grid

    model: MoviesManager.moviesFilter
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
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
    }

    remove: Transition {
        NumberAnimation { property: "opacity"; to: 0; duration: 500 }
    }

    delegate: Rectangle {

        property int movieIndex : index

        width: grid.cellWidth - 8
        height: grid.cellHeight - 10
        border.color: "#2CDE85"
        radius: 4
        border.width: 2
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

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Button {
                    icon.source: "assets/info.svg"
                    icon.height: 20
                    icon.width: 20
                    onClicked: {
                        MoviesManager.setMovieInfo(model.id, movieIndex)
                        info.title = model.title
                        info.poster = model.poster
                    }

                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("More info")
                }

                Button {
                    icon.source: "assets/add.svg"
                    icon.height: 20
                    icon.width: 20

                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Add to Favorites")

                    onPressed: MoviesManager.favorites.addMovie(model.title, model.year, model.poster)
                }
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

    Connections {
        target: MoviesManager
        function onPlotRecieved(plot: string, actors: string, runtime: string, director: string) {
            info.description = plot;
            info.actors = actors
            info.totalRunTime = runtime
            info.director = director
            info.open()
        }
    }
}


