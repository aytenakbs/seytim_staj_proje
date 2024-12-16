import "package:flutter/material.dart";
import "package:seytim_staj/pages/etkinliklerim.dart";
import "package:seytim_staj/pages/profilPage.dart";
import "package:seytim_staj/pages/etkinlikSayfasi.dart";


class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(


      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Etkinliklerim',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profilim',
        ),
      ],
    );
  }
}
