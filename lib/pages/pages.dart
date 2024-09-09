import 'package:flutter/material.dart';

class IndividualPage extends StatefulWidget {
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _noteController = TextEditingController();
  List<String> _notes = [];

  void _addNote() {
    if (_noteController.text.isNotEmpty) {
      setState(() {
        _notes.add(_noteController.text);
        _noteController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Birey'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'BİREY'),
              Tab(icon: Icon(Icons.settings), text: 'İŞLEMLER'),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue[200],
                      child: Icon(Icons.person, size: 25, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NAZLI ZEYNEP ESKİCİ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '19739270288',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Hekim: Hakan ALTUĞLU',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Aile Hekimi: Demet YILDIRIM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Birey Ajanda'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Birey Bilgileri'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Geçmiş Kayıtlar'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.file_copy),
                title: Text('Belgeler'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Ayarlar'),
                onTap: () {},
              ),
              // Diğer drawer öğeleri burada yer alabilir
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'NAZLI ZEYNEP ESKİCİ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '• NAZLI ZEYNEP ESKİCİ adlı bireyin size ilk gelişi:',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text(
                              '• NAZLI ZEYNEP ESKİCİ isimli en son 11.05.2015 tarihinde işlem yapılmış',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Notlar',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _notes
                                .map((note) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text('• $note',
                                          style: TextStyle(fontSize: 16)),
                                    ))
                                .toList(),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _noteController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Yeni not ekleyin',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _addNote,
                            child: Text('Not Ekle'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: Text('Birey Bilgileri')),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text('Hastanın Geçmiş Özeti')),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.add_box),
                      title: Text('Okul Çağı Çocuk/Genç Ara İzlem'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.woman),
                      title: Text('Kadın İzlem'),
                      trailing: Text('Henüz İzlem Yapılmamış',
                          style: TextStyle(color: Colors.green)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.medical_services),
                      title: Text('Muayene'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.science),
                      title: Text('Tetkik'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InspectionProcessesPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.healing),
                      title: Text('Müdahale/Enjeksiyon'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.vaccines),
                      title: Text('Aşı (İzlem Dışında)'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VaccinationPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.description),
                      title: Text('Reçete'),
                      trailing: Text('Son Reçete 11.05.2015',
                          style: TextStyle(color: Colors.green)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrescriptionPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.report),
                      title: Text('Rapor'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.youtube_searched_for_outlined),
                      title: Text('Kanser'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text('Ev Halkı Tes.Fişi'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.family_restroom),
                      title: Text('Aile İçi Şiddet Formu'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrescriptionPage extends StatefulWidget {
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final List<String> tanilar = [
    'soğuk algınlığı',
    'grip',
    'baş ağrısı',
    'karın ağrısı',
    'astım',
    'fıtık',
    'kırık',
    'beyin kanaması',
    'böbrek taşı',
    'bronşit',
    'çölyak',
    'felç',
    'deri hastalıkları',
    'kalp hastalıkları',
  ];

  List<String> filteredTanilar = [];
  String query = '';
  int _selectedTabIndex = 0; // Track the currently selected tab

  @override
  void initState() {
    super.initState();
    filteredTanilar = tanilar;
  }

  void _updateFilteredTanilar(String query) {
    setState(() {
      this.query = query;
      filteredTanilar = tanilar
          .where((tani) => tani.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reçete'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Tanı Listesi'),
              Tab(icon: Icon(Icons.list_alt_sharp), text: 'İlaç Listesi'),
              Tab(icon: Icon(Icons.last_page), text: 'Önceki Reçeteler'),
              Tab(
                  icon: Icon(Icons.medical_information_sharp),
                  text: 'Tıbbi Bilgiler'),
              Tab(icon: Icon(Icons.print), text: 'Yazdır'),
              Tab(icon: Icon(Icons.library_books_sharp), text: 'Sevk Formu'),
              Tab(icon: Icon(Icons.web_outlined), text: 'Rapor Yaz'),
              Tab(icon: Icon(Icons.login_rounded), text: 'Tetkik Girişi'),
              Tab(icon: Icon(Icons.medication), text: 'Majistral İlaç Tanım'),
              Tab(
                  icon: Icon(Icons.medication_outlined),
                  text: 'İlaç Muaf Raporu'),
            ],
            onTap: (index) => setState(() => _selectedTabIndex = index),
          ),
        ),
        body: _selectedTabIndex == 0
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tanı ara...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: _updateFilteredTanilar,
                    ),
                  ),
                  Expanded(
                    child: query.isEmpty
                        ? Center(
                            child: Text('Tanı arama işlemi yapabilirsiniz.'))
                        : ListView(
                            children: filteredTanilar.map((tani) {
                              return ListTile(
                                title: Text(tani),
                                onTap: () {
                                  // Handle tap event if needed
                                  print('Selected: $tani');
                                },
                              );
                            }).toList(),
                          ),
                  ),
                ],
              )
            : SizedBox(),
      ),
    );
  }
}

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<String> reportTypes = [
    'Akli Meleke Raporu',
    'Askere Alınma Muayene Raporu',
    'Balıkçı Gemilerinde Çalışanlar İçin Sağlık Raporu',
    'Bilgilendirme Raporu',
    'Çalışabilir Rapor Kağıdı(EK-2)',
    'Çalışabilir Rapor Kağıdı(Kamu Personeli)',
    'Durum Bildirir Tek Hekim Sağlık Raporu',
    'İstirahat Raporu(Öğrenci-Çalışan-Memur)',
  ];

  String selectedReport = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapor Seçimi'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Rapor Türü Ara',
            ),
            onChanged: (value) {
              setState(() {
                selectedReport = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reportTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(reportTypes[index]),
                  onTap: () {
                    setState(() {
                      selectedReport = reportTypes[index];
                    });
                    if (selectedReport ==
                        'İstirahat Raporu(Öğrenci-Çalışan-Memur)') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestReportPage(),
                        ),
                      );
                    } else if (selectedReport ==
                        'Durum Bildirir Tek Hekim Sağlık Raporu') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleDoctorReportPage(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RestReportPage extends StatefulWidget {
  @override
  _RestReportPageState createState() => _RestReportPageState();
}

class _RestReportPageState extends State<RestReportPage> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${_selectedDate!.toLocal()}'
            .split(' ')[0]; // Format to show only date
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstirahat Raporu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Tarih',
                hintText: 'Tarih Seçiniz',
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Süresi'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Sonuç'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Kurum Adı'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Açıklama'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save or print functionality
              },
              child: Text('Yazdır'),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleDoctorReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Durum Bildirir Tek Hekim Sağlık Raporu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Verilme Nedeni'),
              items: [
                DropdownMenuItem(
                    value: 'İş Sağlığı ve Güvenliği',
                    child: Text('İş Sağlığı ve Güvenliği')),
                DropdownMenuItem(
                    value: 'Yivsiz Av Tüfeği', child: Text('Yivsiz Av Tüfeği')),
                DropdownMenuItem(
                    value: 'Akli Meleke', child: Text('Akli Meleke')),
                DropdownMenuItem(
                    value: 'Genel Durum Değerlendirmesi Kararı',
                    child: Text('Genel Durum Değerlendirmesi Kararı')),
              ],
              onChanged: (value) {},
            ),
            // Diğer alanlar
          ],
        ),
      ),
    );
  }
}

class VaccinationPage extends StatefulWidget {
  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage> {
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  // final TextEditingController _vaccinationController = TextEditingController();

  List<Map<String, String>> _stories = [];
  List<Map<String, String>> _complaints = [];
  List<Map<String, String>> _vaccinations = [];

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} – ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  void _addStory() {
    if (_storyController.text.isNotEmpty) {
      setState(() {
        _stories.add({
          'content': _storyController.text,
          'timestamp': _formatDateTime(DateTime.now()),
        });
        _storyController.clear();
      });
    }
  }

  void _addComplaint() {
    if (_complaintController.text.isNotEmpty) {
      setState(() {
        _complaints.add({
          'content': _complaintController.text,
          'timestamp': _formatDateTime(DateTime.now()),
        });
        _complaintController.clear();
      });
    }
  }

  void _addVaccination(String vaccination) {
    if (vaccination.isNotEmpty) {
      setState(() {
        _vaccinations.add({
          'content': vaccination,
          'timestamp': _formatDateTime(DateTime.now()),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aşı (İzlem Dışında)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hikayeler Bölümü
            _buildSection('Hikayeler', _stories, _storyController, _addStory),
            SizedBox(height: 20),
            // Şikayetler Bölümü
            _buildSection(
                'Şikayetler', _complaints, _complaintController, _addComplaint),
            SizedBox(height: 20),
            // Aşılar Bölümü
            Text(
              'Aşılar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: _vaccinations
                      .map(
                        (vaccination) => ListTile(
                          title: Text(vaccination['content']!),
                          trailing: Text(vaccination['timestamp']!),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double
                  .infinity, // Container genişliğini ekranın tamamına yayar
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                isExpanded: true, // Dropdown genişliğini ekranın tamamına yayar
                items: [
                  DropdownMenuItem(
                      child: Text('Bivalan OPA (Oral Polio Aşısı)'),
                      value: 'Bivalan OPA (Oral Polio Aşısı)'),
                  DropdownMenuItem(
                      child: Text('Trivalan OPA (Oral Polio Aşısı)'),
                      value: 'Trivalan OPA (Oral Polio Aşısı)'),
                  DropdownMenuItem(
                      child: Text('KKK (Kızamık, Kızamıkçık, Kabakulak Aşısı)'),
                      value: 'KKK (Kızamık, Kızamıkçık, Kabakulak Aşısı)'),
                  DropdownMenuItem(
                      child: Text('Hepatit B Aşısı'), value: 'Hepatit B Aşısı'),
                  DropdownMenuItem(
                      child: Text('BCG (Verem Aşısı)'),
                      value: 'BCG (Verem Aşısı)'),
                  DropdownMenuItem(
                      child: Text('Suçiçeği Aşısı'), value: 'Suçiçeği Aşısı'),
                  DropdownMenuItem(
                      child: Text('Pnömokok Aşısı'), value: 'Pnömokok Aşısı'),
                  DropdownMenuItem(
                      child: Text('Rotavirüs Aşısı'), value: 'Rotavirüs Aşısı'),
                  DropdownMenuItem(
                      child: Text('Difteri, Tetanoz, Boğmaca Aşısı'),
                      value: 'Difteri, Tetanoz, Boğmaca Aşısı'),
                  // Diğer aşıları buraya ekleyebilirsiniz...
                ],
                onChanged: (value) {
                  if (value != null) {
                    _addVaccination(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, String>> items,
      TextEditingController controller, VoidCallback onAdd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: items
                  .map(
                    (item) => ListTile(
                      title: Text(item['content']!),
                      trailing: Text(item['timestamp']!),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Yeni $title ekleyin',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: onAdd,
          child: Text('$title Ekle'),
        ),
      ],
    );
  }
}

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajanda'),
      ),
      body: Center(child: Text('Ajanda Page')),
    );
  }
}

class ManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yönetim'),
      ),
      body: Center(child: Text('Yönetim Page')),
    );
  }
}

class ResourceManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaynak Yönetimi'),
      ),
      body: Center(child: Text('Kaynak Yönetimi Page')),
    );
  }
}

class DecisionSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karar Destek'),
      ),
      body: Center(child: Text('Karar Destek Page')),
    );
  }
}

class SMSNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Bildirim'),
      ),
      body: Center(child: Text('SMS Bildirim Page')),
    );
  }
}

class IndividualOperationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Birey İşlemleri'),
      ),
      body: Center(child: Text('Birey İşlemleri Page')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: Center(child: Text('Ayarlar Page')),
    );
  }
}

class Tetkik {
  final String baslik;
  final List<String> tetkikler;

  Tetkik({required this.baslik, required this.tetkikler});
}

class InspectionProcessesPage extends StatefulWidget {
  @override
  _InspectionProcessesPageState createState() =>
      _InspectionProcessesPageState();
}

class _InspectionProcessesPageState extends State<InspectionProcessesPage> {
  List<Tetkik> tetkikler = [
    Tetkik(
      baslik: 'Biyokimya',
      tetkikler: [
        'Magnezyum',
        'Fosfor (P)',
        'Sodyum (Na)',
        'Romatoid faktör (RF)',
        'C reaktif protein (CRP)',
        'Total Protein',
        'Demir(serum)',
        'Demir bağlama kapasitesi (TDBK)',
        'LDL kolesterol',
        'Kolesterol',
        'HDL kolesterol',
        'Trigliserid',
        'Alanin aminotransferaz (ALT)',
        'Aspartat transaminaz (AST)',
        'Bilirubin (direkt)',
        'Bilirubin (total',
        'Gamma glutamil transferaz (GGT)',
        'Laktat dehidrogenaz (LDH)',
        'Glukoz (Açlık Kan Şekeri',
        'Üre (Serum/Plazma)',
        'Kreatinin',
        'Ürik asit',
        'Albümin',
        'Alkalen fosfataz (ALP)',
        'Kalsiyum (Ca)',
        'Klor (Cl)',
        'Potasyum (K)',
      ],
    ),
    Tetkik(
      baslik: 'Elisa',
      tetkikler: [
        'HBsAg',
        'Anti HBs',
        'Anti HIV',
        'Anti HCV',
      ],
    ),
    Tetkik(
      baslik: 'Kart Testler',
      tetkikler: [
        'VDRL-RPR',
      ],
    ),
    Tetkik(
      baslik: 'Hormon',
      tetkikler: [
        'Beta-hCG',
        'PSA total (Prostat spesifik antijen)',
        'Folat',
        'TSH',
        'Ferritin',
        'Vitamin B12',
        'Serbest T4',
        'İnsülin',
      ],
    ),
    Tetkik(
      baslik: 'Hba1c',
      tetkikler: [
        'Glike hemoglobin (Hb A1c)',
      ],
    ),
    Tetkik(
      baslik: 'Tokluk Kan Şekeri',
      tetkikler: [
        'Glukoz(Postprandial 1 saat)',
      ],
    ),
    Tetkik(
      baslik: 'Sedimantasyon',
      tetkikler: [
        'Sedimentasyon',
      ],
    ),
    Tetkik(
      baslik: 'Hemogram',
      tetkikler: [
        'Tam Kan Sayımı (Hemogram)',
      ],
    ),
    Tetkik(
      baslik: 'Idrar',
      tetkikler: [
        'İdrar tetkiki ve mikroskopisi',
      ],
    ),
    Tetkik(
      baslik: 'Kardiyok',
      tetkikler: [
        'Troponin I',
      ],
    ),
    Tetkik(
      baslik: 'Kan Grubu',
      tetkikler: [
        'ABO+Rh tayini (Forward+Reverse)',
      ],
    ),
    Tetkik(
      baslik: 'Talasemi',
      tetkikler: [
        'Hemoglobin varyant analizi (HPLC)(T...',
      ],
    ),
    Tetkik(
      baslik: 'Glukoz (1 saat)',
      tetkikler: [
        'Glukoz-100g OGTT 60. dakika',
      ],
    ),
    Tetkik(
      baslik: 'Glukoz(2 saat)',
      tetkikler: [
        'Glukoz-100g OGTT 120. dakika',
      ],
    ),
    Tetkik(
      baslik: 'Glukoz(3.saat)',
      tetkikler: [
        'Glukoz-100g 180. dakika',
      ],
    ),
  ];
  final Map<String, bool> selectedTetkikler = {};

  @override
  void initState() {
    super.initState();
    // Başlangıçta tüm tetkikleri seçilmemiş olarak işaretle
    tetkikler.forEach((tetkik) {
      tetkik.tetkikler.forEach((tetkikAdi) {
        selectedTetkikler[tetkikAdi] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tetkik Listesi'),
      ),
      body: ListView.builder(
        itemCount: tetkikler.length,
        itemBuilder: (context, index) {
          final kategori = tetkikler[index];
          return ExpansionTile(
            title: Text(kategori.baslik),
            children: kategori.tetkikler.map((tetkik) {
              return CheckboxListTile(
                title: Text(tetkik),
                value: selectedTetkikler[tetkik], // Başlangıçta seçili değil
                onChanged: (value) {
                  setState(() {
                    selectedTetkikler[tetkik] = value!;
                  }); // Seçim durumunu güncelle
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class BireyIslemleriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Birey İşlemleri'),
      ),
      body: Center(child: Text('Birey İşlemleri Page')),
    );
  }
}

class DataTransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veri Aktarımı'),
      ),
      body: Center(child: Text('Veri Aktarımı Page')),
    );
  }
}

class IslemlerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İşlemler Sayfası'),
      ),
      body: Center(child: Text('İşlemler Sayfası')),
    );
  }
}

class USSDecisionSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USS Karar Destek'),
      ),
      body: Center(child: Text('USS Karar Destek Page')),
    );
  }
}

class EndExaminationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Muayene Bitir'),
      ),
      body: Center(child: Text('Muayene Bitir Page')),
    );
  }
}
