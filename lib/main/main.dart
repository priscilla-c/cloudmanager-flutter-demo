import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/data.dart';
import '../mine/mine.dart';

///Created by Zebra-RD張先傑 on 2022年6月15日10:33:40
///Description:APP入口 在Android中冷启动是确实是要比原生慢一大截 热启动倒是感觉不到差异

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  ///關於const的關鍵字 我個人認為它的功能像與final相似 只不過final修飾的是變量 而它是對象
  ///被const關鍵字修飾的集合數組以及實例對象将完全不可变
  ///這個用const修飾而創建的MyApp是作為MyApp類的構造方法來使用的
  const MyApp({Key? key}) : super(key: key);

  ///override 與Java/Kotlin無異 繼承抽象類或實現接口時必須重寫的方法
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///App 名字 經測試只會改變任務列表中的名字 而不是桌面的名字 桌面APP的名字要到生成的不同平台的項目中去修改
      ///比如Android要到AndroidManifest中修改
      title: '云店长',

      ///應用的主題
      theme: ThemeData(
        ///主题颜色
        primarySwatch: Colors.mainwhite,

        ///点击的背景高亮颜色,处理阴影
        highlightColor: Colors.transparent,

        ///設置Scaffold下的Material默認顏色，用于materia應用程序或app內頁面的背景色 相當於Android的windowBackground
        scaffoldBackgroundColor: Colors.mainBack,

        /// 点击时的水波纹颜色设置为透明
        splashColor: Colors.transparent,
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

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ///Data頁面的兩個子頁面名稱
    List tabs = ["文件", "数据"];

    ///DefaultTabController 用於頭部子導航欄與頁面的配合
    return DefaultTabController(
      length: tabs.length,

      ///頁面骨架
      child: Scaffold(
        ///與Android的Toolbar有相似之處 但功能更多
        appBar: createAppBar(tabs),

        ///主體部分 可以配合導航欄進行變動
        body: createPage(),

        ///與Android的FloatingActionButton類似
        floatingActionButton: createActionButton(),

        ///將floatingActionButton與bottomNavigationBar配合 嵌入中間
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        ///與Android的TabLayout與相似之處 導航欄
        bottomNavigationBar: createBottomNavigationBar(),
      ),
    );
  }

  ///当前的TabLayout Position
  int selectedIndex = 0;

  ///用于判断使用哪个组件
  final int locationLeft = 0x100000;
  final int locationRight = 0x200000;

  ///设置点击时的Position
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  ///獲取APPBar控件
  PreferredSizeWidget createAppBar(List<dynamic> tabs) => AppBar(
        ///去掉標題佔用的距離
        toolbarHeight: 0,

        ///設置狀態欄
        systemOverlayStyle: const SystemUiOverlayStyle(
          ///設置狀態欄的背景顏色
          statusBarColor: Colors.white,

          ///設置狀態欄的文字顏色
          statusBarIconBrightness: Brightness.dark,
        ),

        ///去掉陰影效果
        elevation: 0.0,
        bottom: selectedIndex == 0
            ? TabBar(
                padding: const EdgeInsets.only(bottom: 6),
                tabs: [
                  Column(
                    ///文字基於佈局底部對其(縱向)
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(tabs[0]),

                      ///改變文字與下劃線的距離
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 3)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(tabs[1]),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 3)),
                    ],
                  ),
                ],
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.mainGrey,
                indicatorColor: Colors.mainBlue,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 14),
                // indicator: BoxDecoration(
                //     borderRadius: BorderRadius.circular(2),
                //     color: const Color.fromRGBO(255, 221, 107, 1)),
              )
            : null,
      );

  ///獲取主頁控件 雖說Dart沒有對if語句做優化 但是我們可以使用ternary運算符配合表達式來簡化代碼
  Widget createPage() =>
      selectedIndex == 0 ? createHomePage() : createMinePage();

  ///创建底部单个TabLayout
  List<Widget> createTabWidget(int location) => [
        ///加载本地图片
        creteImageWidget(location),

        ///获取文字控件
        createTextWidget(location),
      ];

  ///创建文字控件
  Widget createTextWidget(int location) =>
      Text(location == locationLeft ? "数据" : "我的",
          style: TextStyle(
              color: location == locationLeft
                  ? selectedIndex == 0
                      ? Colors.mainBlue
                      : Colors.black
                  : selectedIndex == 1
                      ? Colors.mainBlue
                      : Colors.black,
              fontSize: 12));

  ///获取图片路径
  Widget creteImageWidget(int location) => Image.asset(
        location == locationLeft
            ? selectedIndex == 0
                ? "assets/images/data_true.png"
                : "assets/images/data_false.png"
            : selectedIndex == 1
                ? "assets/images/mine_true.png"
                : "assets/images/mine_false.png",
        width: 25,
        height: 25,
      );

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

        ///均分底部导航栏横向空间
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
