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

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Etkinliklerim()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EtkinlikSayfasi()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _navigateToPage(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Etkinliklerim',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label:'Etkinlikler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profilim',
        ),
      ],
    );
  }
}
