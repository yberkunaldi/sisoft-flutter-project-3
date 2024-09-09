import 'package:flutter/material.dart';
import 'package:firstproject/pages/pages.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
// ignore: unused_import
//import 'package:http/http.dart' as http;
//import 'package:xml/xml.dart' as xml;
// ignore: unused_import
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class Becktestcontent {
  List<String> degerleri = [
    "Hiç",
    "Hafif Düzeyde Beni pek Etkilemedi",
    "Orta Düzeyde Hoş değildi ama Katlanabildim",
    "Ciddi Düzeyde Dayanmakta çok zorlandım"
  ];
  List<String> olcutler = [
    "Bedeninizin herhangi bir yerinde uyuşma veya karıncalanma",
    "Sıcak/ateş basmaları",
    "Bacaklarda halsizlik, titreme",
    "Gevşeyememe",
    "Çok kötü şeyler olacak korkusu",
    "Baş dönmesi veya sersemlik",
    "Kalp çarpıntısı",
    "Dengeyi kaybetme duygusu",
    "Dehşete kapılma",
    "Sinirlilik",
    "Boğuluyormuş gibi olma duygusu",
    "Ellerde titreme",
    "Titreklik",
    "Kontrolü kaybetme korkuşu",
    "Nefes almada güçlük",
    "Ölüm korkuşu",
    "Korkuya kapılma",
    "Midede hazımsızlık ya da rahatsızlık hissi",
    "Baygınlık",
    "Yüzün kızarması",
    "Terleme (sıcaklığa bağlı olmayan)"
  ];
  Map<String, int> tableData = {};

  Becktestcontent() {
    for (int i = 0; i < this.olcutler.length; i++) {
      olcutekle(olcutler[i]);
    }
  }

  void olcutekle(String s) {
    this.tableData[s] = 0;
  }
}

class BeckTestScreen extends StatefulWidget {
  @override
  _BeckTestScreenState createState() => _BeckTestScreenState();
}

class _BeckTestScreenState extends State<BeckTestScreen> {
  Becktestcontent test = Becktestcontent();
  Map<String, int> answers = {};

  @override
  void initState() {
    super.initState();
    for (var item in test.olcutler) {
      answers[item] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BECK ANKSIYETE OLCEGI'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: test.olcutler.map((question) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<int>(
                    value: answers[question],
                    onChanged: (int? newValue) {
                      setState(() {
                        answers[question] = newValue!;
                      });
                    },
                    items: test.degerleri.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String val = entry.value;
                      return DropdownMenuItem<int>(
                        value: idx,
                        child: Text(val),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int sum = answers.values.reduce((a, b) => a + b);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Test Sonucu"),
                content: Text("Toplam Puan: $sum"),
                actions: <Widget>[
                  TextButton(
                    child: Text("Tamam"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Hasta> bekleyenYaslilar = [];
  static List<Hasta> bekleyenhastalar = [];
  static List<Hasta> bakilanHastalar = [];

  static void muayeneEt(Hasta h) {
    final yas = h.yas;
    if (yas >= 65) {
      bekleyenYaslilar.remove(h);
    }
    for (int i = 0; i < bekleyenhastalar.length; i++) {
      bekleyenhastalar[i].siraNO = i;
    }
    h.hastaMuayenedeMi = true;
    bakilanHastalar.add(h);
  }

  static void muayeneEtSirayaGore() {
    if (bekleyenhastalar.isNotEmpty) {
      Hasta muayenedilen = bekleyenhastalar.removeAt(0);
      final yas = muayenedilen.yas;
      if (yas >= 65) {
        bekleyenYaslilar.remove(muayenedilen);
      }
      bakilanHastalar.add(muayenedilen);
    }
  }

  static void hastaSil(Hasta h) {
    final yas = h.yas;
    if (yas >= 65) {
      bekleyenYaslilar.remove(h);
    }
    bekleyenhastalar.remove(h);
    for (int i = 0; i < bekleyenhastalar.length; i++) {
      bekleyenhastalar[i].siraNO = i;
    }
  }

  static void hastaEkleKuyruga(Hasta h) {
    final int yas = h.yas ?? 0;
    if (yas >= 65) {
      for (int i = 0; i < bekleyenYaslilar.length; i++) {
        bekleyenhastalar.removeAt(i);
      }
      bekleyenYaslilar.add(h);
      bekleyenhastalar = bekleyenYaslilar + bekleyenhastalar;
    } else {
      bekleyenhastalar.add(h);
    }
  }

  static void hastaListesi(List<Hasta> ll) {
    for (int i = 0; i < ll.length; i++) {
      print(ll[i].getInfo());
    }
  }

  static void _addPatient(Hasta patient) {
    bekleyenhastalar.add(patient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[200],
          title: Text('HomePage'),
        ),
        body: Stack(
          children: [],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Yönetim',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_filled),
                title: const Text('ANA SAYFA'),
                onTap: () => {
                  Navigator.pop(context),
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.accessibility_rounded),
                title: const Text('BİREY'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndividualPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.sticky_note_2_sharp),
                title: const Text('AJANDA'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarPage(),
                    ),
                  );
                },
              ),
              ExpansionTile(
                  leading: const Icon(Icons.app_registration),
                  title: const Text('YÖNETİM'),
                  children: <Widget>[
                    ListTile(
                        leading: const Icon(Icons.build_sharp),
                        title: const Text('KAYNAK YÖNETİMİ'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResourceManagementPage(),
                            ),
                          );
                        }),
                    ListTile(
                        leading: const Icon(Icons.zoom_in_map_rounded),
                        title: const Text('KARAR DESTEK'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DecisionSupportPage(),
                            ),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.phone_iphone_outlined),
                        title: Text('SMS BİLDİRİM'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SMSNotificationPage(),
                            ),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.assignment_ind),
                        title: Text('BİREY İŞLEMLERİ'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IndividualOperationsPage(),
                            ),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('AYARLAR'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            ),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.zoom_in_outlined),
                        title: Text('TETKİK İŞLEMLERİ'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BireyIslemleriPage(),
                            ),
                          );
                        }),
                    ListTile(
                        leading: Icon(Icons.assignment_return_sharp),
                        title: Text('VERİ AKTARIMI'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataTransferPage(),
                            ),
                          );
                        }),
                  ]),
              ExpansionTile(
                leading: Icon(Icons.zoom_in_map_rounded),
                title: Text('İŞLEMLER'),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person_pin_outlined),
                    title: const Text('Hasta Kayıt'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HastaEklePage(
                            onPatientAdded: hastaEkleKuyruga,
                          ),
                        ),
                      );
                      // Update the state of the app
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_pin_outlined),
                    title: const Text('Bekleyen Hastalar'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        bilgiPageBekleyen bpage = bilgiPageBekleyen();
                        return bpage.build(context);
                      }));
                      // Update the state of the app
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_pin),
                    title: const Text('Muayene Et'),
                    onTap: () {
                      _HomePageState.muayeneEtSirayaGore();

                      // Update the state of the app
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_pin_rounded),
                    title: const Text('Bakılan Hastalar'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        bilgiPageBakilan bpage = bilgiPageBakilan();
                        return bpage.build(context);
                      }));
                      // Update the state of the app
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_rounded),
                    title: const Text('Beck Anksiyete Testi'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          _BeckTestScreenState beck = _BeckTestScreenState();
                          return beck.build(context);
                        }),
                      );
                      // Update the state of the app
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.people_alt_rounded),
                title: Text('USS KARAR DESTEK'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => USSDecisionSupportPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.people_alt_sharp),
                title: Text('MUAYENEYİ BİTİR'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EndExaminationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class bilgiPageBekleyen extends StatelessWidget {
  final List<Hasta> waitingPatients = _HomePageState.bekleyenhastalar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bekleyen Hasta Listesi'),
      ),
      body: ListView.builder(
        itemCount: waitingPatients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(waitingPatients[index].getInfo()),
          );
        },
      ),
    );
  }
}

class bilgiPageBakilan extends StatelessWidget {
  final List<Hasta> waitingPatients = _HomePageState.bakilanHastalar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bakılan Hasta Listesi'),
      ),
      body: ListView.builder(
        itemCount: waitingPatients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(waitingPatients[index].getInfo()),
          );
        },
      ),
    );
  }
}

abstract class Person {
  String? name;
  String? surname;
}

class Hasta extends Person {
  bool hastaMuayenedeMi = false;
  String? hastaID;
  int? siraNO;
  int yas;
  List<Doktor> hastaneGecmisi = [];

  Hasta({
    required String name,
    required String surname,
    required this.hastaID,
    required this.yas,
  }) {
    this.name = name;
    this.surname = surname;
  }

  String getInfo() {
    return "${this.name}, ${this.surname},${this.yas}";
  }
}

class HastaEklePage extends StatefulWidget {
  final Function(Hasta) onPatientAdded;

  HastaEklePage({required this.onPatientAdded});

  @override
  _HastaEklePageState createState() => _HastaEklePageState();
}

class _HastaEklePageState extends State<HastaEklePage> {
  TextEditingController _isimController = TextEditingController();
  TextEditingController _soyisimController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _yasController = TextEditingController();

  void _submit() {
    final yas = int.tryParse(_yasController.text) ?? 0;
    widget.onPatientAdded(
      Hasta(
        name: _isimController.text,
        surname: _soyisimController.text,
        hastaID: _idController.text,
        yas: yas,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasta Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _isimController,
              decoration: InputDecoration(
                labelText: 'İsim',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _soyisimController,
              decoration: InputDecoration(
                labelText: 'Soyisim',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _yasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Yaş',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Kaydet'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget iconandtext(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: Colors.black),
      SizedBox(width: 8),
      Text(text),
    ],
  );
}

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  _HomePageState2 createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    // Sunucuya göndereceğimiz URL
    final url = Uri.parse('https://ahbs.sisoft.com.tr/sisoft/LoginMan.do');

    // Gönderilecek veriler
    final data = {
      'uskod': _emailController.text,
      'pwd': _passwordController.text,
    };

    // POST isteği gönderme
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'czmfunction': 'doLogin',
        'Czmformno': '1608',
      },
      body: data,
    );

    // Gelen yanıtı işleme
    if (response.statusCode == 200) {
      // Yanıtı konsola yazdırma
      print('Yanıt: ${response.body}');

      // Yanıt gövdesini XML olarak ayrıştırma
      final document = xml.XmlDocument.parse(response.body);
      final codeElement = document.findAllElements('code').first;

      // Yanıtın içeriğine göre işlem yapma
      if (codeElement.text == '1') {
        // İstek başarılı olduysa giriş ekranına yönlendirme
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Yanıttan hata mesajı alma
        final errorMessage = 'Hatalı kullanıcı adı veya parola';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      // Yanıtı konsola yazdırma
      print('Yanıt: ${response}');

      // Bir hata oluştuysa kullanıcıya bildirme
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Geçersiz e-posta veya şifre')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Aile Hekimliği Bilgi Sistemi',
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Form(
              child: Row(
                children: [
                  Image.asset('leftheader.png'),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  Text(
                      "Türkiye'nin en hızlı gelişen aile hekimliği bilgi sistemine hoşgeldiniz. Kullanıcı bilgileriniz ile sisteme giriş yapabilirsiniz"),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      hintText: 'E-postanızı girin',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Parola',
                      hintText: 'Parolanızı girin',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Lütfen E-posta adresinizi giriniz')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Yeni Şifreniz SMS Olarak İletildi')),
                      );
                    }
                  },
                  icon: Icon(Icons.question_mark, color: Colors.grey),
                  label: Text(
                    'Şifremi Unuttum ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => esign(),
                      ),
                    );
                  },
                  child: Text('E-İmza'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    fixedSize: Size(150, 65),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Giriş'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    fixedSize: Size(150, 65),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Image.asset('line.png'),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('rightheader.png'),
            ),
            Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                iconandtext(Icons.check, 'İşletim sistemi bağımsızlığı'),
                iconandtext(Icons.check, 'İnternet tarayıcı bağımsızlığı'),
                iconandtext(Icons.check, 'Hızlı erişim sağlayan akıllı menü'),
                iconandtext(Icons.check, 'Anlık performans takip sistemi'),
                iconandtext(Icons.check, 'Aile bireylerini otomatik tanıma'),
                iconandtext(
                    Icons.check, 'İnsan modeli üzerinden bulgu ekleyebilme'),
              ],
            ),
            SizedBox(height: 20),
            Image.asset('line.png'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Savedoctor(), // Use the imported Savedoctor class
                      ),
                    );
                  },
                  icon: Icon(Icons.account_box_outlined, color: Colors.grey),
                  label: Text(
                    'Yeni Hekim Kaydet ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 35,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Savedoctor extends StatefulWidget {
  @override
  _SavedoctorState createState() => _SavedoctorState();
}

class _SavedoctorState extends State<Savedoctor> {
  bool _isChecked = false; // Checkbox'ın durumu
  bool _isIlceFilled =
      false; // İlçe alanının doldurulup doldurulmadığını kontrol

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.black),
                SizedBox(width: 8),
                Text('Kimlik Bilgileri', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                Text('Aile Hekimi Değilim'),
              ],
            ),
            SizedBox(height: 15),
            textbar('Adı'),
            SizedBox(height: 10),
            textbar('Soyadı'),
            SizedBox(height: 10),
            textbar('TC Kimlik No'),
            SizedBox(height: 10),
            textbar('ÇKYS Kodu'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'İlçe',
                      hintText: '...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isIlceFilled = value.isNotEmpty;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    enabled: _isIlceFilled,
                    decoration: InputDecoration(
                      labelText: 'İl',
                      hintText: '...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (_isChecked == false) ...[
              textbar('A.H. Birim Numarası'),
            ],
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '* Tüm alanların doldurulması zorunludur',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle save action
                },
                child: Text('Kaydet'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textbar(String text) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: text,
        hintText: '...',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class esign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'PIN Numaranızı Giriniz',
                  hintText: '...',
                  prefixIcon: Icon(Icons.sms),
                  border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Gönder'))
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _redirectToUrl();
  }

  Future<void> _redirectToUrl() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('sisofamily.png'),
        backgroundColor: Color.fromARGB(255, 236, 233, 233),
        centerTitle: true,
      ),
      body: HomePage(),
    );
  }
}

class Doktor extends Person {
  String? branch;
  List<Hasta> bakilmisHastalar = [];
  Doktor(String name, String surname, String branch) {
    this.name = name;
    this.surname = surname;
    this.branch = branch;
  }
  void hastaBak(Hasta hasta) {
    this.bakilmisHastalar.add(hasta);
    hasta.hastaneGecmisi.add(this);
  }
}
