import 'package:flutter/material.dart';

///Created by Zebra-RD張先傑 on
///Description:
Widget createDataFileListPage() => Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 14),
          height: 30,
          color: Colors.white,
          child: GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "時間排序",
                  textAlign: TextAlign.center,
                ),
                Image.asset("assets/images/sort.png", width: 20, height: 20),
              ],
            ),
            onTap: () {
              sortData();
            },
          ),
        ),
        ListView(
          children: const <Widget>[

          ],
        ),
      ],
    );

///點擊排序
void sortData() {}
