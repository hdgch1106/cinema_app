import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationbar({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/home/0");
        break;
      case 1:
        context.go("/home/1");
        break;
      case 2:
        context.go("/home/2");
        break;
      case 3:
        context.go("/home/3");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Inicio"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: "Populares"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: "Favoritos"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: "Preferencias"),
      ],
    );
  }
}
