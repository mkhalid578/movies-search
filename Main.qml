import QtQuick
import films

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Component.onCompleted: MoviesManager.getMovies("spiderman")
}