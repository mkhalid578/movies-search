#ifndef MOVIESLISTMODEL_H
#define MOVIESLISTMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QQmlEngine>
#include <QList>

class MoviesListModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT
public:

    enum MovieRoles {
        MovieRole = Qt::UserRole,
        TitleRole,
        YearRole,
        TypeRole,
        PosterRole,
    };
    Q_ENUM(MovieRoles)

    struct MovieInfo {
        QString title;
        QString year;
        QString type;
        QString poster;
    };

    explicit MoviesListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = MovieRoles::MovieRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    void setMovies(const QList<MovieInfo> &movieList);

    QList<MovieInfo> getMovies();

private:

    QHash<int, QByteArray> roleNamesHash;

    QList<MovieInfo> allMovies;

};


#endif // MOVIESLISTMODEL_H
