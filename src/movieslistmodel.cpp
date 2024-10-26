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

void MoviesListModel::addMovie(const QString& title, const QString& year, const QString& poster) {

    MovieInfo info;
    info.title = title;
    info.year = year;
    info.poster = poster;

    //check if movie already exists

    beginInsertRows(QModelIndex(), rowCount(),rowCount());
    allMovies.append(info);
    endInsertRows();




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
