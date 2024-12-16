import 'package:flutter/material.dart';
import 'profilUpdate.dart'; // Güncelleme sayfasının dosyası
import '../widgets/navigation_bar.dart';

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profilim',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8174A0),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/woman.jpeg'), // Arka plan fotoğrafı
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCard('Ad Soyad: $name'),
                const SizedBox(height: 16),
                _buildCard('Email: $email'),
                const SizedBox(height: 16),
                _buildCard('Telefon: $phoneNumber'),
                const SizedBox(height: 16),
                _buildCard('Doğum Tarihi: $birthDate'),
                const SizedBox(height: 16),
                _buildCard('Adres: $address'),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8174A0),
                    ),
                    child: const Text('Profil Güncelle',
                    style:TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget _buildCard(String text) {
    return Card(
      color: Colors.white.withOpacity(0.7),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8174A0),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


