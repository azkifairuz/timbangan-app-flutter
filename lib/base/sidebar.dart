import 'package:flutter/material.dart';
import 'package:timbangan_app/constant/constant.dart';
import 'package:timbangan_app/data/sidebar-data.dart';

class Sidebar extends StatefulWidget {
  final Function(int) onItemSelected;
  const Sidebar({super.key, required this.onItemSelected});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final data = SidebarData();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: primaryColor,
      child: ListView.builder(
          itemCount: data.menu.length,
          itemBuilder: (context, index) => buildMenuEntry(data, index)),
    );
  }

  Widget buildMenuEntry(SidebarData data, int index) {
    final isSelected = selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: isSelected ? selectionColor : Colors.transparent),
      child: InkWell(
        onTap: () {setState(() {
          selectedIndex = index;
          });
          widget.onItemSelected(index);
        },

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? primaryColor : Colors.white,
              ),
            ),
            Text(
              data.menu[index].title,
              style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? primaryColor: Colors.white,
                  fontWeight: isSelected ? FontWeight.bold :  FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
