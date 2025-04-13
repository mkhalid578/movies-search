#ifndef MOVIESMANAGER_H
#define MOVIESMANAGER_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QQmlEngine>

#include "movieslistmodel.h"
#include "moviesfilter.h"


class MoviesManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(MoviesFilter* moviesFilter MEMBER moviesFilter CONSTANT)
    Q_PROPERTY(MoviesListModel* favorites MEMBER favorites CONSTANT)

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
    Q_INVOKABLE void setMovieInfo(QString id, int row);



    static MoviesManager &instance()
    {
        static MoviesManager instance;
        return instance;
    }


signals:
    void plotRecieved(QString plot, QString actors, QString runtime, QString director);
    void movieExistsAlready();
    void movieAdded(QString title);

private:

    explicit MoviesManager(QObject *parent = nullptr);

    QNetworkAccessManager* manager{nullptr};
    QNetworkRequest* request {nullptr};
    MoviesListModel *movies;
    MoviesListModel* favorites;
    MoviesFilter *moviesFilter;

};

#endif // MOVIESMANAGER_H
