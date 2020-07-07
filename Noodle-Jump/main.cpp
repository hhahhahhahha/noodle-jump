#include <QApplication>
#include <FelgoApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "controller.h"


int main(int argc, char *argv[])
{

  QApplication app(argc, argv);

  FelgoApplication felgo;
  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("manager", new Controller);//注册到元对象系统，一边qml调用
  felgo.initialize(&engine);
  felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
  engine.load(QUrl(felgo.mainQmlFileName()));

  return app.exec();
}
