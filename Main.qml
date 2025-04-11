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

    property Component moviesPage: MoviesPage {}
    property Component favoritesPage: Favorites {}

    // menuBar: RowLayout {

    //     width: 200
    //     height: 45


    //     TextField {
    //         id: search
    //         leftPadding: 28

    //         Image {
    //             id: searchIcon
    //             source: "assets/search.svg"
    //             width: 24
    //             height: 24
    //             anchors.verticalCenter: parent.verticalCenter
    //             anchors.left: parent.left
    //             anchors.margins: 2
    //         }

    //         onTextChanged: MoviesManager.moviesFilter.setFilterFixedString(text);
    //     }
    // }


    ColumnLayout {

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            TabButton {
                text: qsTr("Movies")
                onClicked: console.log(tabBar.currentIndex)
            }
            TabButton {
                text: qsTr("Favorites")
                onClicked: console.log(tabBar.currentIndex)
            }
        }

        Loader {
            id: loader
            sourceComponent: tabBar.currentIndex == 0 ? moviesPage : favoritesPage
            Layout.fillWidth: true
        }
    }

}




