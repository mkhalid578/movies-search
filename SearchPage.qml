import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import films

Item {
    signal search()

    RowLayout {
        anchors.centerIn: parent

        TextField {
            id: find

            Layout.margins: 10
            Layout.preferredWidth: 360
            Layout.preferredHeight: 45
            font.pixelSize: 30
            placeholderText: qsTr("Find movies...")

            Keys.onReturnPressed: {MoviesManager.getMovies(text); search()}
        }
    }
}
