cmake_minimum_required(VERSION 3.16)

project(movies VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appmovies
    main.cpp
)

include_directories(
    src/
)

qt_add_qml_module(appmovies
    URI films
    VERSION 1.0
    QML_FILES
        pages/Favorites.qml
        pages/MoviesPage.qml
        components/InfoModal.qml
        components/Notifications.qml
        components/CardButton.qml
        components/MovieCard.qml
        components/SearchBar.qml
        components/MenuButton.qml
        Main.qml

    SOURCES
        src/movieslistmodel.h
        src/movieslistmodel.cpp
        src/moviesmanager.h
        src/moviesmanager.cpp
        src/moviesfilter.h
        src/moviesfilter.cpp
    RESOURCES
        images.qrc
)


target_link_libraries(appmovies
    PRIVATE Qt6::Quick Qt6::Network
)

