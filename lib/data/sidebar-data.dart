import 'package:flutter/material.dart';
import 'package:timbangan_app/models/sidebar-model.dart';

class SidebarData {
  final menu = const <SidebarModel>[
    SidebarModel(icon: Icons.scale, title: "Home"),
    SidebarModel(icon: Icons.info_rounded, title: "Information"),
    SidebarModel(icon: Icons.settings, title: "Settings"),
  ];
}