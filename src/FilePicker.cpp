#include "FilePicker.h"
#include <QFileDialog>
#include <QDir>
#include <QDebug>
#include <QCoreApplication>
#include <QApplication>

FilePicker::FilePicker(QObject *parent)
    : QObject(parent)
{
    qDebug() << "FilePicker::FilePicker - Constructor called";
    qDebug() << "FilePicker::FilePicker - QCoreApplication instance:" << QCoreApplication::instance();
    if (QCoreApplication::instance()) {
        qDebug() << "FilePicker::FilePicker - Application type:" << typeid(*QCoreApplication::instance()).name();
    }
}

void FilePicker::openFileDialog(const QString &title, const QString &filter)
{
    qDebug() << "========================================";
    qDebug() << "FilePicker::openFileDialog CALLED";
    qDebug() << "Title:" << title;
    qDebug() << "Filter:" << filter;
    qDebug() << "QCoreApplication::instance():" << QCoreApplication::instance();
    
    if (!QCoreApplication::instance()) {
        qDebug() << "ERROR: No QCoreApplication instance!";
        return;
    }
    
    // Check if we have QApplication (not just QGuiApplication)
    QApplication *app = qobject_cast<QApplication*>(QCoreApplication::instance());
    if (!app) {
        qDebug() << "WARNING: QCoreApplication is not QApplication, file dialog might not work!";
        qDebug() << "Application type:" << typeid(*QCoreApplication::instance()).name();
    } else {
        qDebug() << "OK: QApplication instance found";
    }
    
    qDebug() << "About to call QFileDialog::getOpenFileName...";
    
    // QFileDialog::getOpenFileName works with QApplication (which we now use in main.cpp)
    // This will show the native Windows file dialog
    QString filePath = QFileDialog::getOpenFileName(
        nullptr,  // Parent widget - nullptr works fine, shows as separate window
        title,
        QDir::homePath(),  // Start in home directory
        filter
    );

    qDebug() << "QFileDialog::getOpenFileName returned";
    qDebug() << "FilePath length:" << filePath.length();
    qDebug() << "FilePath:" << (filePath.isEmpty() ? "(empty/cancelled)" : filePath);
    qDebug() << "========================================";

    if (!filePath.isEmpty()) {
        m_selectedFile = filePath;
        qDebug() << "FilePicker: Emitting fileSelected signal with:" << filePath;
        emit fileSelected(filePath);
        qDebug() << "FilePicker: Signal emitted successfully";
    } else {
        qDebug() << "FilePicker: No file selected (user cancelled or error)";
    }
}

