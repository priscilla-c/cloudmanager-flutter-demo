import 'package:flutter/material.dart';

import '../home/data.dart';
import '../mine/mine.dart';

///Created by Zebra-RD张先杰 on 2022年6月15日10:33:40
///Description:APP入口 在Android中冷启动是确实是要比原生慢一大截 热启动倒是感觉不到差异

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  ///关于const的关键字 我个人认为它的功能像是修饰变量的final一样 被final修饰的变量必须初始化并且不能改变变量的值 也就是变成了常量
  ///而const关键字是用来修饰集合数组以及实例对象的 在创建时被const代替new所修饰的对象将完全不可变
  ///这个用const修饰而创建的MyApp是作为MyApp类的构造方法来使用的
  const MyApp({Key? key}) : super(key: key);

  ///override 与Java/Kotlin无异，继承抽象类或实现接口时必须重写的方法
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///APP 名字 经测试只会改变任务列表中的名字 而不是桌面的名字 桌面APP的名字要到每个不同的项目中去修改 比如Android要到AndroidManifest中修改
      title: '云店长',
      theme: ThemeData(
        ///主题颜色
        primarySwatch: Colors.blue,
      ),

      ///APP 首页路由
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  ///required 意为必填参数
  const MainPage({Key? key}) : super(key: key);

  /// =>这是一个DART的语法糖 就像是kotlin中的 = 一样
  /// State<MyHomePage> createState(){
  ///    return _MyHomePageState()
  /// }
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createPage(),
      floatingActionButton: createActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: createBottomNavigationBar(),
    );
  }

  ///当前的TabLayout Position
  int selectedIndex = 0;

  ///獲取主頁控件
  Widget createPage() {
    if (selectedIndex == 0) {
      return createHomePage();
    } else {
      return createMinePage();
    }
  }

  ///设置点击时的Position
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  ///用于判断使用哪个组件
  final int locationLeft = 0x100000;
  final int locationRight = 0x200000;

  ///创建底部单个TabLayout
  List<Widget> createTabWidget(int location) {
    return [
      ///加载本地图片
      Image.asset(
        getImageUrl(location),
        width: 25,
        height: 25,
      ),

      ///获取文字控件
      createTextWidget(location),
    ];
  }

  ///创建文字控件
  Widget createTextWidget(int location) {
    if (location == locationLeft) {
      if (selectedIndex == 0) {
        return const Text("数据",
            style: TextStyle(color: Colors.mainBlue, fontSize: 12));
      } else {
        return const Text("数据",
            style: TextStyle(color: Colors.black, fontSize: 12));
      }
    } else {
      if (selectedIndex == 0) {
        return const Text("我的",
            style: TextStyle(color: Colors.black, fontSize: 12));
      } else {
        return const Text("我的",
            style: TextStyle(color: Colors.mainBlue, fontSize: 12));
      }
    }
  }

  ///获取图片路径
  String getImageUrl(int location) {
    if (location == locationLeft) {
      if (selectedIndex == 0) {
        return "assets/images/data_true.png";
      } else {
        return "assets/images/data_false.png";
      }
    } else {
      if (selectedIndex == 1) {
        return "assets/images/mine_true.png";
      } else {
        return "assets/images/mine_false.png";
      }
    }
  }

  ///中间按钮被点击
  void bottomClickListener() {}

  ///创建底部按钮
  Widget createActionButton() {
    return FloatingActionButton(
      onPressed: bottomClickListener,
      child: Image.asset(
        "assets/images/connect.png",
        width: 60,
        height: 60,
      ),
    );
  }

  ///创建底部导航栏
  Widget createBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),

      ///該控件是一個橫向佈局的容器
      child: Row(
        children: [
          ///該控件主要是為了監聽點擊事件
          GestureDetector(
            ///Container作為一個容器可以約束圖片文字的位置 但Padding也可以約束 使用它的主要原因還是為了擴大點擊事件的範圍
            ///很神奇的一件事 當我給這個Container控件附上顏色時 點擊事件的範圍被擴大 否則與未使用無異
            child: Container(
              height: 50,
              width: 150,
              color: Colors.white,

              ///該控件是一個縱向佈局的容器
              child: Column(
                ///約束子控件居中
                mainAxisAlignment: MainAxisAlignment.center,

                ///以子控件的寬高來決定自己的寬高 相當於Android中的wrap_content
                mainAxisSize: MainAxisSize.min,
                children: createTabWidget(locationLeft),
              ),
            ),
            onTap: () {
              onItemTapped(0);
            },
          ),
          const SizedBox(),
          GestureDetector(
            child: Container(
              height: 50,
              width: 150,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: createTabWidget(locationRight),
              ),
            ),
            onTap: () {
              onItemTapped(1);
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        ///均分底部导航栏横向空间
      ),
    );
  }
}
