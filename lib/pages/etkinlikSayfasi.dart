import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seytim_staj/widgets/navigation_bar.dart';
import 'etkinlikDetaySayfasi.dart';

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
  String? _selectedLocation; // Seçilen konumu tutmak için bir değişken
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

  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Konum Seçici
              TextField(
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Konum seç...",
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tarih Seçici
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: _selectedDate ?? "Tarih seç...",
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Filtreleme işlemi
                  if (_selectedLocation != null || _selectedDate != null) {
                    final filtered = _etkinlikler.where((etkinlik) {
                      // Konuma veya tarihe göre filtreleme mantığı buraya eklenebilir
                      return true; // Örnek: Tüm etkinlikler eşleşiyor
                    }).toList();
                    setState(() {
                      _filteredEtkinlikler = filtered;
                    });
                  }
                  Navigator.pop(context); // Modalı kapat
                },
                child: const Text("Filtrele"),
              ),
            ],
          ),
        );
      },
    );
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
                    .where((etkinlik) =>
                    etkinlik.toLowerCase().contains(query.toLowerCase()))
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
              onPressed: _openFilterModal, // Modal aç
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EtkinlikDetayPage(
                              etkinlikAdi: _filteredEtkinlikler[index],
                            ),
                          ),
                        );
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