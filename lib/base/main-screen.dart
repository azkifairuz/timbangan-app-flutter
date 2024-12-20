import 'package:flutter/material.dart';
import 'package:timbangan_app/base/sidebar.dart';
import 'package:timbangan_app/screen/configuration.dart';
import 'package:timbangan_app/screen/home.dart';
import 'package:timbangan_app/screen/info.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final appScreens = [
    const ReadDataScale(),
    const InfoPage(),
    const ConfigPage(),
  ];
   int selectedIndex = 0;
  void onSidebarItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(child: Row(
          children: [
            Expanded(
                flex:2,
                child: Sidebar(onItemSelected: onSidebarItemSelected)
            ),
            Expanded(
                flex: 8,
                child:  appScreens[selectedIndex])
          ],
        ))
    );;
  }
}
