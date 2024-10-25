cmake_minimum_required(VERSION 3.16)

project(movies VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appmovies
    main.cpp
)

qt_add_qml_module(appmovies
    URI films
    VERSION 1.0
    QML_FILES
        InfoModal.qml
        Main.qml
    SOURCES
        movieslistmodel.h
        movieslistmodel.cpp
        moviesmanager.h
        moviesmanager.cpp
    RESOURCES
        info.svg
        add.svg
        close.svg
        SOURCES moviesfilter.h moviesfilter.cpp
)


target_link_libraries(appmovies
    PRIVATE Qt6::Quick Qt6::Network
)

