cmake_minimum_required(VERSION 3.16)

project(movies VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

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
        MoviesPage.qml
        InfoModal.qml
        Main.qml
        SearchPage.qml
        Favorites.qml
    SOURCES
        src/movieslistmodel.h
        src/movieslistmodel.cpp
        src/moviesmanager.h
        src/moviesmanager.cpp
        src/moviesfilter.h
        src/moviesfilter.cpp
    RESOURCES
        assets/info.svg
        assets/add.svg
        assets/close.svg
        RESOURCES assets/filter.svg
        RESOURCES assets/search.svg
        RESOURCES assets/back.svg
        QML_FILES Notifications.qml
)


target_link_libraries(appmovies
    PRIVATE Qt6::Quick Qt6::Network
)

