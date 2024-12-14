import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'etkinlikDetaySayfasi.dart';
import 'navigation_bar.dart';

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
  String? _selectedDate;
  String _kategoriArama = '';
  int _currentIndex = 1; // Etkinlik sayfası varsayılan olarak seçili

  @override
  void initState() {
    super.initState();
    _filteredEtkinlikler = _etkinlikler;
  }

  void _openSearchModal() {
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
              const Text(
                "Etkinlik Ara",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Kategori girin...",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _kategoriArama = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Tarih: ${_selectedDate ?? "Seçin"}",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                  border: const OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filteredEtkinlikler = _etkinlikler.where((etkinlik) {
                      return etkinlik.toLowerCase().contains(_kategoriArama.toLowerCase());
                    }).toList();
                  });
                  Navigator.pop(context);
                },
                child: const Text("Ara"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selected != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(selected);
      });
    }
  }

  void _onNavBarTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AnaSayfa()),
        );
        break;
      case 1:
      // Etkinlik sayfasındayız, hiçbir şey yapma
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AyarlarSayfasi()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etkinlikler"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                setState(() {
                  _filteredEtkinlikler = _etkinlikler
                      .where((etkinlik) => etkinlik.toLowerCase().contains(query.toLowerCase()))
                      .toList();
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
              onPressed: _openSearchModal,
              child: const Text("Arama ve Filtrele"),
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
                            builder: (context) =>
                                EtkinlikDetayPage(etkinlikAdi: _filteredEtkinlikler[index]),
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
        onTap: _onNavBarTap,
      ),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Ana Sayfa")),
    );
  }
}

class AyarlarSayfasi extends StatelessWidget {
  const AyarlarSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Ayarlar Sayfası")),
    );
  }
}
