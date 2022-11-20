#include "filereader.h"

FileReader::FileReader(QObject *parent)
    : QObject{parent}
{

}

QVector<QString> FileReader::getLabels() { return labels; }

void FileReader::readFile()
{

   QString auxText(file.readAll());
   arrText = auxText.split("###");

   int i = 0;
   if (!arrText.startsWith("###"))
       i = 1;
   begin = i;

   for (; i < arrText.length(); i += 2)
   {
       //qDebug() << arrText[i].toLower().trimmed().replace(" ", "");

       if (begin > 0)
       {
           QString label = arrText[i];
           if(!labels.contains(label)){
                labels.push_back(label);
            }
      }
  }

   emit finishFileRead();
}

void FileReader::generatePdf(QVector<QString> arrInputText)
{

    QMap<QString, QString> map = mapLabelsToInputs(arrInputText);
        int i = begin;
        html ="<p>";
        for (; i < arrText.length(); i += 2)
        {
            QString label = arrText[i];
            QString lineEdit = map[label];
            html+=arrText[i-1] +"<b>" + lineEdit +"</b>";
        }

         html +="</p>";

}


void FileReader::openFile()
{
    QString str = filename.split("///")[1].replace("/","\\");
    this->file.setFileName(str);
    if(file.open(QIODevice::ReadOnly)){
        emit fileopened();
    }else{
        qDebug() << "file is not oppened " +file.errorString()+ " + filename";
    }
}

void FileReader::closeFile()
{

    file.close();

}

void FileReader::displayPdf(const QString &filename)
{

    QDesktopServices::openUrl( QUrl::fromLocalFile(filename) );

}

void FileReader::setFilename(const QString &filename)
{

    this->filename = filename;
    emit filenameChanged();
}

QString FileReader::getFilename() const
{
   return this->filename;
}

QMap<QString,QString> FileReader::mapLabelsToInputs(QVector<QString> arrInputText)
{
    QMap<QString,QString> map;
    for (int var = 0; var < labels.size(); ++var) {
        map.insert(labels[var],arrInputText[var]);
    }
    return map;
}

void FileReader::guardar(const QString &filename)

{

    qDebug() <<"saving file with name..."+filename;

    QString str = filename.split("///")[1].replace("/","\\");

    QTextDocument documento;
    QPrinter impresora(QPrinter::HighResolution);
    impresora.setOutputFormat(QPrinter::PdfFormat);
    impresora.setOutputFileName(str);
    impresora.setPageMargins(QMargins(20, 30, 20, 15));

    documento.setHtml(html);
    documento.print(&impresora);
    emit fileSaved();
}
