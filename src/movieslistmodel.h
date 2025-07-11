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
        DescriptionRole,
        IdRole
    };
    Q_ENUM(MovieRoles)

    struct MovieInfo {
        QString id;
        QString title;
        QString year;
        QString type;
        QString poster;
        QString description;

        bool operator==(const MovieInfo& other) const {
            return (id == other.id && title == other.title && type == other.type);
        }
    };

    explicit MoviesListModel(QObject *parent = nullptr);

    Q_INVOKABLE void addMovie(const QString& title, const QString& year, const QString& poster);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = MovieRoles::MovieRole) const override;

    bool setData(const QModelIndex& index, const QVariant& value, int role = MovieRoles::MovieRole) override;

    QHash<int, QByteArray> roleNames() const override;

    void setMovies(const QList<MovieInfo> &movieList);
    void setMovieInfo(QString description, int row);

    QList<MovieInfo> getMovies();

    void loadMovies();

    void saveMovies();



private:

    QHash<int, QByteArray> roleNamesHash;
    QList<MovieInfo> allMovies;

signals:
    void titleAdded(QString title);
    void titleExists();


};


#endif // MOVIESLISTMODEL_H
