#ifndef FILEPICKER_H
#define FILEPICKER_H

#include <QObject>
#include <QString>
#include <QUrl>

class FilePicker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString selectedFile READ selectedFile NOTIFY fileSelected)

public:
    explicit FilePicker(QObject *parent = nullptr);
    QString selectedFile() const { return m_selectedFile; }

    Q_INVOKABLE void openFileDialog(const QString &title, const QString &filter);

signals:
    void fileSelected(const QString &filePath);

private:
    QString m_selectedFile;
};

#endif // FILEPICKER_H

