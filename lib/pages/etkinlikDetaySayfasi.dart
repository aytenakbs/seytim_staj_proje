import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EtkinlikDetayPage extends StatefulWidget {
  final String etkinlikAdi;

  const EtkinlikDetayPage({Key? key, required this.etkinlikAdi}) : super(key: key);

  @override
  _EtkinlikDetayPageState createState() => _EtkinlikDetayPageState();
}

class _EtkinlikDetayPageState extends State<EtkinlikDetayPage> {
  bool isJoined = false;

  // Google Maps için başlangıç konumu
  static const LatLng etkinlikKonumu = LatLng(37.77483, -122.41942); // Örnek konum (San Francisco)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4D1B6), // Arka plan rengi
      appBar: AppBar(
        title: const Text(
          'Etkinlik Detayları', // Başlık değiştirildi
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Simge rengi beyaz
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Şeffaf AppBar
        elevation: 0, // Gölgeyi kaldırdık
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20), // Yazı rengi beyaz
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/cocukatolye.jpeg', // Etkinlik resmi
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Etkinlik Açıklaması: ${widget.etkinlikAdi} hakkında detaylar burada yer alacak.',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tarih ve Saat: 12 Aralık 2024, 18:00',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kontenjan: 25 kişi',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Google Maps Widget
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Kenar yuvarlaklığı
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: etkinlikKonumu, // Başlangıç konumu
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('etkinlikKonumu'),
                      position: etkinlikKonumu,
                      infoWindow: const InfoWindow(
                        title: 'Etkinlik Konumu',
                        snippet: 'San Francisco',
                      ),
                    ),
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isJoined = !isJoined;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isJoined ? Colors.red : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  isJoined ? 'İptal Et' : 'Katıl',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
