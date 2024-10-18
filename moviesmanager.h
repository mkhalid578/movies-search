#ifndef MOVIESMANAGER_H
#define MOVIESMANAGER_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QQmlEngine>

#include "movieslistmodel.h"


class MoviesManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(MoviesListModel* movies MEMBER movies CONSTANT)

public:

    static MoviesManager *create(QQmlEngine *qmlEngine, QJSEngine *jsEngine)
    {
        Q_UNUSED(jsEngine)
        Q_ASSERT(qmlEngine);
        qmlEngine->setObjectOwnership(&MoviesManager::instance(),
                                      QQmlEngine::CppOwnership);
        return &MoviesManager::instance();

    }

    Q_INVOKABLE void getMovies(QString title);


    static MoviesManager &instance()
    {
        static MoviesManager instance;
        return instance;
    }



private:

    explicit MoviesManager(QObject *parent = nullptr);

    QNetworkAccessManager* manager{nullptr};
    QNetworkRequest* request {nullptr};
    MoviesListModel *movies;

};

#endif // MOVIESMANAGER_H
