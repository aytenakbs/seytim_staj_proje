import 'package:flutter/material.dart';
import 'package:seytim_staj/widgets/navigation_bar.dart';
import 'package:seytim_staj/pages/etkinlikDetaySayfasi.dart';
import 'package:seytim_staj/pages/etkinlikSayfasi.dart'; // Etkinlik modelini import ediyoruz

class Etkinliklerim extends StatefulWidget {
  @override
  _EtkinliklerimState createState() => _EtkinliklerimState();
}

class _EtkinliklerimState extends State<Etkinliklerim> {
  final List<Etkinlik> _etkinlikler = [
    Etkinlik(
      baslik: "Anne Çocuk Etkinliği",
      aciklama: "Bu etkinlik, anneler ve çocukların birlikte keyifli vakit geçirebileceği eşsiz aktiviteler sunuyor. Çocuklar 'Duygularımızı Canlandıralım mı?' atölyesi ile sanat aracılığıyla duygularını ifade etmeyi öğreniyor. 'Zuzu ile Çöpleri Çöpten Kurtarıyoruz' etkinliği, çevre bilinci oluşturarak müzik ve hikaye anlatımıyla çocuklara doğayı sevdiriyor. Lego ve robotik atölyelerinde, minik mühendisler STEM becerilerini geliştirme şansı buluyor. Anneler için de rehberlik sunan bu etkinlik, hem eğitici hem de eğlenceli bir deneyim sunuyor.",
      tarihSaat: "12 Aralık 2025, 10:00",
      fotoUrl: "assets/images/cocukatolye.jpeg",
      konum: "Adana, Türkiye",
      kontenjan: 20,
      ikon: Icons.family_restroom,
    ),
    Etkinlik(
      baslik: "Yoga Etkinliği",
      aciklama: "Bu etkinlik, hem bedeninizi hem de ruhunuzu yenilemek için mükemmel bir fırsat. Sabah seanslarında enerji artırıcı yoga pratikleriyle güne zinde başlayabilirsiniz. Hatha Yoga dersleri, temel pozlar ve nefes teknikleriyle bedeninize esneklik ve güç kazandıracak. Surya Namaskara (Güneşe Selam) hareket serisi, geleneksel bir yoga deneyimi sunarak zihninizi dinginleştirecek. Adana'nın huzurlu atmosferinde düzenlenen bu etkinlik, içsel bir yolculuk için idealdir.",
      tarihSaat: "15 Aralık 2024, 09:00",
      fotoUrl: "assets/images/yogaatolye.jpeg",
      konum: "Adana, Türkiye",
      kontenjan: 30,
      ikon: Icons.spa,
    ),

    // Diğer etkinlikler...
  ];

  void _navigateToDetailPage(Etkinlik etkinlik) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EtkinlikDetayPage(etkinlik: etkinlik),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etkinliklerim", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF8174A0),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backgrflower.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: _etkinlikler.length,
              itemBuilder: (context, index) {
                final etkinlik = _etkinlikler[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(
                      etkinlik.baslik,
                      style: const TextStyle(color: Color(0xFF8174A0)),
                    ),
                    leading: Icon(etkinlik.ikon, color: const Color(0xFFA5B68D)),
                    trailing: const Icon(Icons.arrow_forward, color: Color(0xFF8174A0)),
                    onTap: () => _navigateToDetailPage(etkinlik),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
