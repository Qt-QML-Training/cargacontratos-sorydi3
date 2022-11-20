#ifndef FILEREADER_H
#define FILEREADER_H

#include <QObject>
#include <QVector>
#include <QMap>
#include <QFile>
#include <QtPrintSupport/QPrinter>
#include <QTextDocument>
#include <QDesktopServices>


class FileReader : public QObject
{
    Q_OBJECT
public:
    explicit FileReader(QObject *parent = nullptr);
    Q_INVOKABLE QVector<QString> getLabels();
    Q_INVOKABLE void readFile();
    Q_INVOKABLE void generatePdf(QVector<QString> arrInputText);
    Q_INVOKABLE void openFile();
    Q_INVOKABLE void closeFile();
    Q_INVOKABLE void displayPdf(const QString &filename);

    void setFilename(const QString &filename);
    QString getFilename() const;
    Q_PROPERTY(QString filename READ getFilename WRITE setFilename NOTIFY filenameChanged);
    Q_INVOKABLE void guardar(const QString &filename);
signals:
    void finishFileRead();
    void filenameChanged();
    void fileopened();
    void fileSaved();
private:
    QMap<QString,QString> mapLabelsToInputs(QVector<QString> arrInputText);

private:
   int begin;
   QFile file;
   QString filename;
   QVector<QString> arrText;
   QVector<QString> labels;
   QString html;
};

#endif // FILEREADER_H
