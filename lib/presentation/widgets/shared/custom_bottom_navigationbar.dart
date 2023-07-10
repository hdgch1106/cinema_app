import 'package:flutter/material.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Inicio"),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: "Categorías"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: "Favoritos"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: "Preferencias"),
      ],
    );
  }
}
