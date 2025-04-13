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

    property Component moviesPage: MoviesPage {}
    property Component favoritesPage: Favorites {}

    Notifications {
        id: notifications
    }

    ColumnLayout {

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            TabButton {
                id: movieBtn
                icon.source: "assets/movie.svg"
                icon.color: tabBar.currentIndex === 0 ? "black" : "white"
                text: qsTr("Movies")
            }
            TabButton {
                text: qsTr("Favorites")
                icon.source: "assets/favorites.svg"
                icon.color: tabBar.currentIndex === 1 ? "black" : "white"
            }
            TabButton {
                text: qsTr("Settings")
                icon.source: "assets/settings.svg"
                icon.color: tabBar.currentIndex == 2 ? "black" : "white"
            }
        }

        Loader {
            id: loader
            sourceComponent: {
                if (tabBar.currentIndex === 0) {

                    return moviesPage
                } else if (tabBar.currentIndex === 1) {
                    return favoritesPage
                } else {
                    return;
                }
            }

            Layout.fillWidth: true
        }
    }
}




