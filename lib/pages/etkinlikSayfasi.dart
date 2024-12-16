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
  String? _selectedDate;
  String? _selectedLocation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _filteredEtkinlikler = _etkinlikler;
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
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
              TextField(
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Konum seç...",
                  hintStyle: TextStyle(color: Color(0xFF8174A0)),
                  prefixIcon: const Icon(Icons.location_on, color: Color(0xFF8174A0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xFF8174A0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF8174A0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                  hintStyle: TextStyle(color: Color(0xFF8174A0)),
                  prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF8174A0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xFF8174A0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF8174A0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_selectedLocation != null || _selectedDate != null) {
                    final filtered = _etkinlikler.where((etkinlik) {
                      return true;
                    }).toList();
                    setState(() {
                      _filteredEtkinlikler = filtered;
                    });
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8174A0),
                ),
                child: const Text(
                  "Filtrele",
                  style: TextStyle(color: Colors.white),
                ),
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
        title: const Text("Etkinlikler",style:TextStyle(color:Colors.white) ),
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
                    hintStyle: TextStyle(color: Color(0xFF8174A0)),
                    prefixIcon: const Icon(Icons.manage_search_rounded, color: Color(0xFF8174A0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF8174A0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF8174A0)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _openFilterModal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8174A0),
                  ),
                  child: const Text(
                    "Arama Filtrele",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredEtkinlikler.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(
                            _filteredEtkinlikler[index],
                            style: const TextStyle(color: Color(0xFF8174A0)),
                          ),
                          leading: const Icon(Icons.event, color: Color(0xFFA5B68D)),
                          trailing: const Icon(Icons.arrow_forward, color: Color(0xFF8174A0)),
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
        ],
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
