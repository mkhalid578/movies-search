#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QList>

#include <QDebug>

#include "src/moviesmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MoviesManager::instance();


    QObject::connect(QCoreApplication::instance(), &QCoreApplication::aboutToQuit, []() {
        emit MoviesManager::instance().saveMovies();
    });



    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("films", "Main");



    return app.exec();
}
