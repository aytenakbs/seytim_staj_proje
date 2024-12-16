import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'etkinlikDetaySayfasi.dart';
import '../widgets/navigation_bar.dart';

class Etkinliklerim extends StatefulWidget {
  const Etkinliklerim({Key? key}) : super(key: key);

  @override
  _EtkinliklerimState createState() => _EtkinliklerimState();
}

class _EtkinliklerimState extends State<Etkinliklerim> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etkinliklerim"),
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
                            builder: (context) => EtkinlikDetayPage(etkinlikAdi: _filteredEtkinlikler[index]),
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
      bottomNavigationBar: CustomNavigationBar(currentIndex: 1),
    );
  }
}
