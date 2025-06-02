#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>

#include "movieslistmodel.h"

MoviesListModel::MoviesListModel(QObject* parent)
    : QAbstractListModel(parent)
{
    roleNamesHash[MovieRole] = "movie";
    roleNamesHash[TitleRole] = "title";
    roleNamesHash[YearRole] = "year";
    roleNamesHash[TypeRole] = "type";
    roleNamesHash[PosterRole] = "poster";
    roleNamesHash[DescriptionRole] = "description";
    roleNamesHash[IdRole] = "id";
}

int MoviesListModel::rowCount(const QModelIndex &parent) const
{
    return allMovies.size();
}

QHash<int, QByteArray> MoviesListModel::roleNames() const
{
    return roleNamesHash;
}

QVariant MoviesListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    int row = index.row();
    if(row < 0 || row >= allMovies.size())
    {
        return QVariant();
    }
    const MovieInfo &info= allMovies.at(row);

    switch (role)
    {
    case TitleRole:
        return info.title;
    case YearRole:
        return info.year;
    case TypeRole:
        return info.type;
    case PosterRole:
        return info.poster;
    case DescriptionRole:
        return info.description;
    case IdRole:
        return info.id;

    default:
        return QVariant();
    }
}

bool MoviesListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid())
        return false;

    int row = index.row();
    if(row < 0 || row >= allMovies.size())
    {
        return false;
    }

    MovieInfo info = allMovies.at(row);

    switch (role)
    {
    case TitleRole:
        info.title = value.toString();
        break;
    case YearRole:
        info.year = value.toString();
        break;
    case TypeRole:
        info.type = value.toString();
        break;
    case PosterRole:
        info.poster = value.toString();
        break;
    case DescriptionRole:
        info.description = value.toString();
        break;
    case IdRole:
        info.id = value.toString();
        break;

    default:
        return false;
    }

    allMovies.replace(row, info);
    return true;

}


void MoviesListModel::setMovies(const QList<MovieInfo> &movieList)
{
    beginResetModel();
    allMovies.clear();
    allMovies = movieList;
    endResetModel();
}

void MoviesListModel::loadMovies()
{
    QList<MovieInfo> moviesFromJson;

    QFile file("output.json");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open JSON file.");
        return;
    }

    QByteArray jsonData = file.readAll();
    file.close();

    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(jsonData, &parseError);
    if (parseError.error != QJsonParseError::NoError) {
        qWarning() << "JSON parse error:" << parseError.errorString();
        return;
    }

    if (!doc.isArray()) {
        qWarning("JSON is not an object");
        return;
    }

    QJsonArray moviesList = doc.array();

    for (auto movieListItem: moviesList) {
        QJsonObject obj = movieListItem.toObject();
        MovieInfo movie;
        movie.title = obj["title"].toString();
        movie.description = obj["description"].toString();
        movie.poster = obj["poster"].toString();

        moviesFromJson.append(movie);
    }


    setMovies(moviesFromJson);


}

void MoviesListModel::saveMovies()
{
    QJsonDocument movieJsonDoc;
    QJsonArray moviesJsonArray;

    foreach (auto movie, allMovies) {
        QJsonObject movieObj;
        movieObj["title"] = movie.title;
        movieObj["description"] = movie.description;
        movieObj["year"] = movie.year;
        movieObj["poster"] = movie.poster;
        movieObj["type"] = movie.type;
        movieObj["id"] = movie.id;

        moviesJsonArray.append(movieObj);
    }

    QJsonDocument doc(moviesJsonArray);

    QByteArray jsonData = doc.toJson(QJsonDocument::Indented);

    QFile file("output.json");

    if (file.open(QIODevice::WriteOnly)) {
        file.write(jsonData);
        file.close();

    }



}

void MoviesListModel::addMovie(const QString& title, const QString& year, const QString& poster) {

    MovieInfo info;
    info.title = title;
    info.year = year;
    info.poster = poster;

    //check if movie already exists
    if(!allMovies.contains(info)) {
        beginInsertRows(QModelIndex(), rowCount(),rowCount());
        allMovies.append(info);
        endInsertRows();

        emit titleAdded(info.title);

    } else {
        emit titleExists();
    }
}

void MoviesListModel::setMovieInfo(QString description, int row)
{
    MovieInfo info = allMovies.at(row);
    info.description = description;

    beginResetModel();
    allMovies.replace(row, info);
    endResetModel();
}

QList<MoviesListModel::MovieInfo> MoviesListModel::getMovies()
{
    return allMovies;
}
