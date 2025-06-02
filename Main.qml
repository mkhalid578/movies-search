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


    Notifications {
        id: notifications
        anchors.bottom: parent.bottom
        anchors.margins: 10
    }

    ColumnLayout {

        anchors.fill: parent

        TabBar {
            id: tabBar
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 4
            spacing: 10
            MenuButton {
                width: 150
                text: qsTr("Movies")
                icon.source: "qrc:/assets/movie.svg"
            }
            MenuButton {
                width: 150
                text: qsTr("Favorites")
                icon.source: "qrc:/assets/favorites.svg"
                // icon.color: tabBar.currentIndex === 1 ? "black" : "white"
            }
            MenuButton {
                width: 150
                text: qsTr("Settings")
                icon.source: "qrc:/assets/settings.svg"
                // icon.color: tabBar.currentIndex == 2 ? "black" : "white"
            }
        }

        StackLayout {
            id: stack

            currentIndex: tabBar.currentIndex


            MoviesPage {
                id: moviesPage
            }
            Favorites {
                id: favoritesPage
            }
        }
    }




    // Loader {
    //     id: loader
    //     sourceComponent: {
    //         if (tabBar.currentIndex === 0) {

    //             return moviesPage
    //         } else if (tabBar.currentIndex === 1) {
    //             return favoritesPage
    //         } else {
    //             return;
    //         }
    //     }

    //     Layout.fillWidth: true
    // }
}




