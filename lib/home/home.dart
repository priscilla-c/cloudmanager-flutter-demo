import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  //required 意为必填参数
  const MyHomePage({Key? key}) : super(key: key);

  // =>这是一个DART的语法糖 就像是kotlin中的 = 一样
  // State<MyHomePage> createState(){
  //    return _MyHomePageState()
  // }
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getHomeImageUrl() {
    if (_selectedIndex == 0) {
      return "assets/images/data_true.png";
    } else {
      return "assets/images/data_false.png";
    }
  }

  String getMineImageUrl() {
    if (_selectedIndex == 1) {
      return "assets/images/mine_true.png";
    } else {
      return "assets/images/mine_false.png";
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              getHomeImageUrl(),
              width: 25,
              height: 25,
            ),
            label: "数据",
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                getMineImageUrl(),
                width: 25,
                height: 25,
              ),
              label: "我的"),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.mainBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
