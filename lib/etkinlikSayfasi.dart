import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seytim_staj/navigation_bar.dart';

class EtkinlikSayfasi extends StatefulWidget {
  @override
  _EtkinlikSayfasiState createState() => _EtkinlikSayfasiState();
}

class _EtkinlikSayfasiState extends State<EtkinlikSayfasi> {
  final List<String> _etkinlikler = [
    "Flutter Workshop",
    "Teknoloji Konferansı",
    "Mobil Geliştirici Buluşması",
    "Konser",
    "Tasarım ve UX Eğitimi"
  ];

  List<String> _filteredEtkinlikler = [];
  String? _selectedDate; // Seçilen tarihi tutmak için bir değişken
  int _currentIndex = 0; // Navigation bar'daki seçili sekme

  @override
  void initState() {
    super.initState();
    _filteredEtkinlikler = _etkinlikler; // Başlangıçta tüm etkinlikler gösterilir
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index; // Seçili sekmeyi güncelle
    });

    switch (index) {
      case 0:
        print("Ana Sayfa seçildi");
        break;
      case 1:
        print("Arama seçildi");
        break;
      case 2:
        print("Ayarlar seçildi");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etkinlikler"),
        centerTitle: true, // Başlık ortala
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                final filtered = _etkinlikler
                    .where((etkinlik) => etkinlik.toLowerCase().contains(query.toLowerCase()))
                    .toList();
                setState(() {
                  _filteredEtkinlikler = filtered;
                });
              },
              decoration: InputDecoration(
                hintText: "Etkinlik ara...",
                prefixIcon: const Icon(Icons.manage_search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {}, // Modal açma veya başka bir işlev eklenebilir
              child: const Text("Arama Filtrele"),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredEtkinlikler.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_filteredEtkinlikler[index]),
                      leading: const Icon(Icons.event),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        print("${_filteredEtkinlikler[index]} tıklandı.");
                      },
                    ),
                  );
                },
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

void main() {
  runApp(MaterialApp(
    home: EtkinlikSayfasi(),
    theme: ThemeData(primarySwatch: Colors.blue),
  ));
}
