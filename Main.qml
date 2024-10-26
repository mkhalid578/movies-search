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

    property Component searchPage: SearchPage {onSearch: loader.sourceComponent = moviesPage }
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

                onPressed: loader.sourceComponent = searchPage
            }

            Button {
                icon {
                    source: "assets/filter.svg"
                    width: 24
                    height: 24
                    color: "black"
                }

                text: "Filter"
            }

            Button {
                text: "Favorites"

                onClicked: loader.sourceComponent = favoritesPage
            }

            TextField {
                id: search
                leftPadding: 24

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
        sourceComponent: searchPage
        anchors.fill: parent
    }
}
