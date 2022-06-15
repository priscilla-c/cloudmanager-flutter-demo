import 'package:flutter/material.dart';

import 'home/home.dart';

//APP入口 在Android中冷启动是确实是要比原生慢一大截 热启动倒是感觉不到差异
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //关于const的关键字 我个人认为它的功能像是修饰变量的final一样 被final修饰的变量必须初始化并且不能改变变量的值 也就是变成了常量
  //而const关键字是用来修饰集合数组以及实例对象的 在创建时被const代替new所修饰的对象将完全不可变
  //这个用const修饰而创建的MyApp是作为MyApp类的构造方法来使用的
  const MyApp({Key? key}) : super(key: key);

  //override 与Java/Kotlin无异，继承抽象类或实现接口时必须重写的方法
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //APP 名字 经测试只会改变任务列表中的名字 而不是桌面的名字 桌面APP的名字要到每个不同的项目中去修改 比如Android要到AndroidManifest中修改
      title: '云店长',
      theme: ThemeData(
        //主题颜色
        primarySwatch: Colors.blue,
      ),
      //APP 首页路由
      home: const MyHomePage(),
    );
  }
}
