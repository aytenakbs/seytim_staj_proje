import 'package:flutter/material.dart';
import 'package:seytim_staj/widgets/navigation_bar.dart';
import 'package:seytim_staj/pages/etkinlikDetaySayfasi.dart';

// Etkinlik Modeli
class Etkinlik {
  final String baslik;
  final String aciklama;
  final String tarihSaat;
  final String fotoUrl;
  final String konum;
  final int kontenjan;
  final IconData ikon;

  Etkinlik({
    required this.baslik,
    required this.aciklama,
    required this.tarihSaat,
    required this.fotoUrl,
    required this.konum,
    required this.kontenjan,
    required this.ikon,
  });
}

class EtkinlikSayfasi extends StatefulWidget {
  @override
  _EtkinlikSayfasiState createState() => _EtkinlikSayfasiState();
}

class _EtkinlikSayfasiState extends State<EtkinlikSayfasi> {
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
    Etkinlik(
      baslik: "Teknoloji Konferansı",
      aciklama: "Teknoloji dünyasındaki son gelişmeleri öğrenmek için bu konferansa katılın! Yapay zeka, blockchain, nesnelerin interneti gibi konularda uzman konuşmacılar bilgi paylaşacak. Katılımcılar, geleceğin teknolojik trendlerini ilk elden keşfetme şansı yakalayacak. Workshoplar ve interaktif oturumlarla, hem profesyoneller hem de öğrenciler için büyük fırsatlar sunuluyor. Adana'da düzenlenen bu etkinlikte, teknolojiyi şekillendiren yenilikleri keşfedin.",
      tarihSaat: "15 Aralık 2024, 09:00",
      fotoUrl: "assets/images/tek.jpeg",
      konum: "Adana, Türkiye",
      kontenjan: 200,
      ikon: Icons.computer,
    ),
    Etkinlik(
      baslik: "Sanat Sergisi",
      aciklama: "Adana'nın sanatseverleri için eşsiz bir deneyim! Bu sergi, yerel ve uluslararası sanatçıların büyüleyici eserlerini bir araya getiriyor. Yağlı boya tablolar, heykeller ve dijital sanat eserleri, farklı temaları keşfetmeniz için sizleri bekliyor. Sergi alanında düzenlenecek olan interaktif sanat atölyeleri, ziyaretçilerin kendi yaratıcılıklarını keşfetmelerine olanak tanıyor. Sanat tutkunları için ilham dolu bir etkinlik olan bu sergi, unutulmaz bir deneyim sunuyor.",
      tarihSaat: "15 Aralık 2024, 09:00",
      fotoUrl: "assets/images/sanat.jpeg",
      konum: "Adana, Türkiye",
      kontenjan: 50,
      ikon: Icons.palette,
    ),
    Etkinlik(
      baslik: "Golf Kulübü Etkinliği",
      aciklama: "Adana'daki golf tutkunları için düzenlenen bu etkinlikte hem eğlence hem de rekabet bir arada! Golf eğitmenlerinden özel dersler alabilir ve turnuvalara katılarak yeteneklerinizi sergileyebilirsiniz. Etkinlik sırasında açık havada piknik alanları ve sosyal etkinliklerle keyifli vakit geçirebilirsiniz. Yeni başlayanlar için temel eğitimlerin yanı sıra, profesyoneller için özel müsabakalar düzenleniyor. Doğa ile iç içe bir deneyim sunan bu etkinlik, golf severlerin buluşma noktası olacak.",
      tarihSaat: "15 Aralık 2024, 09:00",
      fotoUrl: "assets/images/golf.jpeg",
      konum: "Adana, Türkiye",
      kontenjan: 100,
      ikon: Icons.golf_course,
    ),
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
        title: const Text("Etkinlikler", style: TextStyle(color: Colors.white)),
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
