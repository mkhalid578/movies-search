#include "moviesfilter.h"
#include "movieslistmodel.h"

MoviesFilter::MoviesFilter(QObject *parent)
    : QSortFilterProxyModel{parent}
{
    setFilterRole(MoviesListModel::YearRole);
    sort(0, Qt::AscendingOrder);
    setFilterCaseSensitivity(Qt::CaseInsensitive);
}

void MoviesFilter::filterBy(QString filter)
{
    qDebug() << "filter changed";

    if (filter == "year") {
        setFilterRole(MoviesListModel::YearRole);
    } else if (filter == "title") {
        setFilterRole(MoviesListModel::TitleRole);
    }
}
