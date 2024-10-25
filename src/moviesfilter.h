#ifndef MOVIESFILTER_H
#define MOVIESFILTER_H

#include <QObject>
#include <QQmlEngine>
#include <QSortFilterProxyModel>

class MoviesFilter : public QSortFilterProxyModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MoviesFilter(QObject *parent = nullptr);

    Q_INVOKABLE void filterBy(QString filter);

};

#endif // MOVIESFILTER_H
