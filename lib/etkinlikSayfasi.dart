import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String? _selectedDate;  // Seçilen tarihi tutmak için bir değişken

  @override
  void initState() {
    super.initState();
    _filteredEtkinlikler = _etkinlikler; // Başlangıçta tüm etkinlikler gösterilir
  }

  void _openSearchModal() {
    String _kategoriArama = '';

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
              Text(
                "Etkinlik Ara",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Kategori girin...",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _kategoriArama = value; // Kategori değerini al
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Tarih: ${_selectedDate != null ? _selectedDate : "Seçin"}",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Kullanıcı klavye ile tarih girmesin, sadece takvimden seçsin
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Kategori ve tarih filtrelemesi
                  final filtered = _etkinlikler.where((etkinlik) {
                    return etkinlik.toLowerCase().contains(_kategoriArama.toLowerCase());
                  }).toList();

                  setState(() {
                    _filteredEtkinlikler = filtered; // Filtrelenmiş etkinlikleri güncelle
                  });
                  Navigator.pop(context); // Modal'ı kapat
                },
                child: const Text("Ara"),
              ),
            ],
          ),
        );
      },
    );
  }

  // Tarih seçmek için takvim açma fonksiyonu
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Başlangıç tarihi bugünkü tarih
      firstDate: DateTime(2000), // Geçmiş tarih sınırı
      lastDate: DateTime(2101), // Gelecek tarih sınırı
    );

    if (selected != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(selected); // Seçilen tarihi formatlayarak kaydet
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etkinlikler"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                // Varsayılan arama
                final filtered = _etkinlikler
                    .where((etkinlik) => etkinlik.toLowerCase().contains(query.toLowerCase()))
                    .toList();
                setState(() {
                  _filteredEtkinlikler = filtered; // Kullanıcı adıyla etiketleri filtrele
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
            // Arama butonu ekleyin
            ElevatedButton(
              onPressed: _openSearchModal, // Modalı aç
              child: const Text("Arama Filtrele"),
            ),
            const SizedBox(height: 10),
            // Etkinlik Listesi
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
    );
  }

  DateFormat(String s) {}
}

void main() {
  runApp(MaterialApp(
    home: EtkinlikSayfasi(),
    theme: ThemeData(primarySwatch: Colors.blue),
  ));
}