import 'package:cloudmanager_flutter/data/data_details.dart';
import 'package:cloudmanager_flutter/data/data_file_list.dart';
import 'package:flutter/material.dart';

///Created by Zebra-RD張先傑 on 2022年6月15日14:40:27
///Description:Scaffold-Body-數據頁面
Widget createHomePage() => TabBarView(
      children: <Widget>[
        createDataFileListPage(),
        createDataDetailsPage(),
      ],
    );
