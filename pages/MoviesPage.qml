import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import films


ColumnLayout {

    anchors.fill: parent

    SearchBar {
        id: search
        Layout.margins: 10
        Layout.preferredWidth: 360
        Layout.preferredHeight: 45
        Layout.alignment: Qt.AlignCenter

        onSearchEntered: {
            MoviesManager.getMovies(text);
        }
    }

    InfoModal {
        id: info
        anchors.centerIn: parent
    }


    GridView {
        id: grid


        width: 960
        height: 500
        cellWidth: 320
        cellHeight: 350
        z: 1
        clip: true

        Layout.margins: 10


        model: MoviesManager.moviesFilter

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0; to: 1.0
                duration: 500
            }
        }

        populate: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
        }

        remove: Transition {
            NumberAnimation { property: "opacity"; to: 0; duration: 500 }
        }

        delegate: MovieCard {
            width: grid.cellWidth - 20
            height: grid.cellHeight - 20
            poster: model.poster
            title: model.title
            year: model.year
            movieId: model.id
            movieIndex: index

            onAddPressed: {
                MoviesManager.favorites.addMovie(
                            model.title, model.year, model.poster)

            }

            onInfoPressed: {
                MoviesManager.setMovieInfo(model.id, movieIndex)
                info.title = model.title
                info.poster = model.poster
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


