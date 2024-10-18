#include <QJsonDocument>
#include <QJsonArray>

#include "moviesmanager.h"

MoviesManager::MoviesManager(QObject *parent)
    : QObject(parent)
{
    movies = new MoviesListModel(this);
    manager = new QNetworkAccessManager(this);
    request = new QNetworkRequest();

}

void MoviesManager::getMovies(QString title)
{

    request->setUrl(QUrl(QString("https://www.omdbapi.com/?apiKey=%1&s=%2").arg("7a077fb8", title)));
    request->setHeader(QNetworkRequest::ContentTypeHeader, "application/json");


    QNetworkReply* reply = manager->get(*request);

    QObject::connect(reply, &QNetworkReply::finished,[reply]() {
        QByteArray responseBytes = reply->readAll();
        QJsonDocument json = QJsonDocument::fromJson(responseBytes);
        if (!responseBytes.isNull()) {
            qDebug() << json;

        }
        else {
            qDebug() << "failed to make request";
        }
        reply->deleteLater();
    });

}



