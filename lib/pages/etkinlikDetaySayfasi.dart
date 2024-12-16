import 'package:flutter/material.dart';

class EtkinlikDetayPage extends StatefulWidget {
  final String etkinlikAdi;

  const EtkinlikDetayPage({Key? key, required this.etkinlikAdi}) : super(key: key);

  @override
  _EtkinlikDetayPageState createState() => _EtkinlikDetayPageState();
}

class _EtkinlikDetayPageState extends State<EtkinlikDetayPage> {
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.etkinlikAdi, textAlign: TextAlign.center),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/etkinlik_resmi.png', // Etkinlik resmi
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
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(
                child: Text(
                  'Harita Placeholder',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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