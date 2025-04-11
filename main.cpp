#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>

#include <QDebug>

#include "src/moviesmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MoviesManager::instance();

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
