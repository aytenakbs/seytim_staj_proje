import 'package:flutter/material.dart';
import 'profilUpdate.dart'; // Güncelleme sayfasının dosyası
import 'navigation_bar.dart'; // Navigation bar widget'ını ekle

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Sayfası',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilPage(),
    );
  }
}

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final String name = "Ahmet Yılmaz";
  final String email = "ahmet@example.com";
  final String phoneNumber = "012-3456-7890";
  final String birthDate = "01/01/1990";
  final String address = "İstanbul, Türkiye";
  int _currentIndex = 2; // Profil sayfası varsayılan olarak seçili

  void _onNavBarTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AnaSayfa()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EtkinlikSayfasi()),
        );
        break;
      case 2:
      // Profil sayfasındayız, bir şey yapma
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ad Soyad: $name',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Telefon: $phoneNumber',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Doğum Tarihi: $birthDate',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Adres: $address',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                  );
                },
                child: const Text('Profil Güncelle'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana Sayfa")),
      body: const Center(child: Text("Ana Sayfa İçeriği")),
    );
  }
}

class EtkinlikSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Etkinlikler")),
      body: const Center(child: Text("Etkinlik Sayfası İçeriği")),
    );
  }
}
