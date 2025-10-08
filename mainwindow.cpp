#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <QPalette>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    
    // Set the text color to a nice blue
    ui->nameLabel->setStyleSheet("color: #2c3e50; background-color: transparent;");
    
    // Set window title
    setWindowTitle("Manahil Ahmed Shaikh - Qt Application");
}

MainWindow::~MainWindow()
{
    delete ui;
}
