#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QList>

#include "moviesmanager.h"

MoviesManager::MoviesManager(QObject *parent)
    : QObject(parent)
{
    movies = new MoviesListModel(this);
    moviesFilter = new MoviesFilter(this);

    favorites = new MoviesListModel(this);
    manager = new QNetworkAccessManager(this);
    request = new QNetworkRequest();

    moviesFilter->setSourceModel(movies);

    connect(favorites, &MoviesListModel::titleExists,
            this, &MoviesManager::movieExistsAlready);

}

void MoviesManager::getMovies(QString title)
{

    request->setUrl(QUrl(
        QString("https://www.omdbapi.com/?apiKey=%1&s=%2").arg("7a077fb8", title)));
    request->setHeader(QNetworkRequest::ContentTypeHeader,
                       "application/json");


    QNetworkReply* reply = manager->get(*request);



    QObject::connect(reply, &QNetworkReply::finished,[reply, this]() {
        QByteArray responseBytes = reply->readAll();
        QJsonDocument json = QJsonDocument::fromJson(responseBytes);
        qDebug() << json;
        QList<MoviesListModel::MovieInfo> totalMovies;
        if (!responseBytes.isNull()) {
            QJsonArray listofMovies = json["Search"].toArray();

            for (auto movie: listofMovies) {
                QJsonObject movieObj = movie.toObject();
                MoviesListModel::MovieInfo movieInfo;
                movieInfo.title = movieObj["Title"].toString();
                movieInfo.poster = movieObj["Poster"].toString();
                movieInfo.type = movieObj["Type"].toString();
                movieInfo.year = movieObj["Year"].toString();
                movieInfo.id = movieObj["imdbID"].toString();

                totalMovies.append(movieInfo);
            }

            movies->setMovies(totalMovies);
        }
        else {
            qDebug() << "failed to make request";
        }
        reply->deleteLater();
    });

}

void MoviesManager::setMovieInfo(QString id, int row)
{
    request->setUrl(QUrl(
        QString("https://www.omdbapi.com/?apiKey=%1&i=%2").arg(
            "7a077fb8", id)));
    request->setHeader(QNetworkRequest::ContentTypeHeader,
                       "application/json");


    QNetworkReply* reply = manager->get(*request);

    QObject::connect(reply, &QNetworkReply::finished,[reply, row, this]() {
        QByteArray responseBytes = reply->readAll();
        QJsonDocument json = QJsonDocument::fromJson(responseBytes);
        if (!responseBytes.isNull()) {
            QString plot = json["Plot"].toString();
            QString actors = json["Actors"].toString();
            QString runtime = json["Runtime"].toString();
            QString director = json["Director"].toString();

            emit plotRecieved(plot, actors, runtime, director);
        }
        else {
            qDebug() << "failed to make request";
        }
        reply->deleteLater();
    });


}




