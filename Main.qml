import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import films

Window {
    id: root
    width: 960
    height: 640
    visible: true
    title: qsTr("Qt Movies")
    color: "black"

    property string filter: ""

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

    ColumnLayout {
        anchors.fill: parent

        InfoModal {
            id: info
            anchors.centerIn: parent
        }

        RowLayout {
            spacing: 5
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignHCenter

            TextField {
                id: find

                Layout.margins: 10
                Layout.preferredWidth: 360
                Layout.preferredHeight: 45
                font.pixelSize: 30
                placeholderText: qsTr("Find movies...")

                Keys.onReturnPressed: MoviesManager.getMovies(text)

            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.margins: 4
            Layout.alignment: Qt.AlignHCenter

            ComboBox {
                model: ["year", "title"]
                displayText: currentText.toUpperCase()
                onActivated: MoviesManager.moviesFilter.filterBy(currentValue);
                Layout.preferredWidth: 240
                Layout.preferredHeight: 45
            }

            TextField {
                id: filter

                Layout.margins: 10
                Layout.preferredWidth: 360
                Layout.preferredHeight: 45
                font.pixelSize: 30
                placeholderText: qsTr("Filter by...")

                onTextChanged: MoviesManager.moviesFilter.setFilterFixedString(text)

            }
        }

        GridView {
            id: grid
            Layout.fillWidth: true
            Layout.preferredHeight: 400
            Layout.margins: 5
            model: MoviesManager.moviesFilter
            cellWidth: 310
            cellHeight: 350
            clip: true

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
        }
    }
}
