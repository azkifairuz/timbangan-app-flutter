import 'package:flutter/material.dart';
import 'package:timbangan_app/base/sidebar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Row(
        children: [
          const Expanded(
              flex:2,
              child: Sidebar()
          ),
          Expanded(
              flex: 8,
              child: Container(color: Colors.green,))
        ],
      ))
    );
  }
}
