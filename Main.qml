import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import films

ApplicationWindow {
    id: root
    width: 960
    height: 640
    visible: true
    title: qsTr("Qt Movies")

    property Component searchPage: SearchPage {onSearch: loader.sourceComponent = root.moviesPage }
    property Component moviesPage: MoviesPage {}
    property Component favoritesPage: Favorites {}

    menuBar: RowLayout {

        width: 200
        height: 45

        Button {
            icon {
                source: "assets/back.svg"
                width: 24
                height: 24
                color: "black"
            }

            onPressed: loader.sourceComponent = root.searchPage
        }

        Button {
            icon {
                source: "assets/filter.svg"
                width: 24
                height: 24
                color: "black"
            }

            text: "Filter"

            onClicked: popup.open();

            Popup
            {
                id: popup

                // x: parent.x
                y: parent.height + 10
                width: 600
                height: 400

                enter: Transition {
                    NumberAnimation  {
                        property: "opacity";
                        from: 0; to: 1;
                        duration: 350
                    }
                }

                TabBar {
                    id: bar
                    width: parent.width / 2
                    TabButton {
                        id: tab
                        text: qsTr("Properties")
                        contentItem: Text {
                            text: tab.text
                            font.pixelSize: 24
                            font.underline: bar.currentIndex == 0
                        }
                    }
                    TabButton {
                        text: qsTr("Metrics")
                    }
                }

                StackLayout {
                    width: parent.width
                    currentIndex: bar.currentIndex
                    Item {
                        id: homeTab
                    }
                    Item {
                        id: discoverTab
                    }
                }
            }
        }

        Button {
            text: "Favorites"

            onClicked: loader.sourceComponent = root.favoritesPage
        }

        TextField {
            id: search
            leftPadding: 28

            Image {
                id: searchIcon
                source: "assets/search.svg"
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.margins: 2
            }

            onTextChanged: MoviesManager.moviesFilter.setFilterFixedString(text);
        }
    }



    Loader {
        id: loader
        sourceComponent: root.searchPage
        anchors.fill: parent
    }
}
