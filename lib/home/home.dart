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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final int locationLeft = 0x100000;
  final int locationRight = 0x200000;

  //获取图标与文字
  List<Widget> getTabWidget(int location) {
    return [
      const Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      ),
      Image.asset(
        getImageUrl(location),
        width: 25,
        height: 25,
      ),
      getTextWidget(location),
      const Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      ),
    ];
  }

  //获取文字控件
  Widget getTextWidget(int location) {
    if(location == locationLeft){
      if (_selectedIndex == 0) {
        return const Text("数据", style: TextStyle(color: Colors.mainBlue));
      } else {
        return const Text("数据", style: TextStyle(color: Colors.black));
      }
    }else{
      if (_selectedIndex == 0) {
        return const Text("我的", style: TextStyle(color: Colors.black));
      } else {
        return const Text("我的", style: TextStyle(color: Colors.mainBlue));
      }
    }
  }

  //获取图片路径
  String getImageUrl(int location) {
    if(location == locationLeft){
      if (_selectedIndex == 0) {
        return "assets/images/data_true.png";
      } else {
        return "assets/images/data_false.png";
      }
    }else{
      if (_selectedIndex == 1) {
        return "assets/images/mine_true.png";
      } else {
        return "assets/images/mine_false.png";
      }
    }
  }

  //中间按钮被点击
  void _bottomClickListener() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bottomClickListener,
        tooltip: '蓝牙',
        child: Image.asset(
          "assets/images/connect.png",
          width: 25,
          height: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            Column(mainAxisSize: MainAxisSize.min,
                children:getTabWidget(locationLeft)
            ),
            const SizedBox(), //中间位置空出
            Column(
              mainAxisSize: MainAxisSize.min,
              children: getTabWidget(locationRight),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
    );
  }
}
