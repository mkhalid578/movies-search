#include "movieslistmodel.h"

MoviesListModel::MoviesListModel(QObject* parent)
    : QAbstractListModel(parent)
{
    roleNamesHash[MovieRole] = "movie";
    roleNamesHash[TitleRole] = "title";
    roleNamesHash[YearRole] = "year";
    roleNamesHash[TypeRole] = "type";
    roleNamesHash[PosterRole] = "poster";
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

    default:
        return QVariant();
    }
}


void MoviesListModel::setMovies(const QList<MovieInfo> &movieList)
{
    beginResetModel();
    allMovies.clear();
    allMovies = movieList;
    endResetModel();
}

QList<MoviesListModel::MovieInfo> MoviesListModel::getMovies()
{
    return allMovies;
}
