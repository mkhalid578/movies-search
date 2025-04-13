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
                text: qsTr("Movies")
            }
            TabButton {
                text: qsTr("Favorites")
            }
        }

        Loader {
            id: loader
            sourceComponent: tabBar.currentIndex === 0 ? moviesPage : favoritesPage
            Layout.fillWidth: true
        }
    }
}




