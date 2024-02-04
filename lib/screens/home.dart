import 'package:flutter/material.dart';
import '../core/storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> user = {};

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
  ];

  checkLogin() async {
    Storage storage = Storage();

    final loadedUser = await storage.loadUser();
    if (loadedUser != null) {
      setState(() {
        user = loadedUser;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  // Bottom bar öğelerine tıklandığında çağrılacak metod
  void _onItemTapped(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
    // Eğer "People" ikonuna tıklanırsa CommunicationPage'e git
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommunicationPage()),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfilePage()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessageScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, size: 30),
      ),
      body: _pages[_selectedIndex], // Seçilen sayfayı göster

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.phone, size: 30, color: Colors.orange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail, size: 30, color: Colors.orange),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30, color: Colors.orange),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Seçilen öğe rengi
        unselectedItemColor: Colors.blue, // Seçilmeyen öğe rengi
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/ben.png"),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/orangett.png"),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Onay iletişim kutusu göster
                    bool logoutConfirmed = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Onay"),
                          content:
                              Text("Çıkış yapmak istediğinize emin misiniz?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(true); // Kullanıcı çıkışı onayladı
                              },
                              child: Text("Evet"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(false); // Kullanıcı çıkışı iptal etti
                              },
                              child: Text("Hayır"),
                            ),
                          ],
                        );
                      },
                    );

                    // İletişim kutusunun sonucunu kontrol et
                    if (logoutConfirmed == true) {
                      // Kullanıcı çıkışı onayladı
                      Storage storage = Storage();
                      await storage.clearUser();
                      Navigator.of(context).pushReplacementNamed("/login");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 241, 122, 113), // arka planı değiştiriyoruz
                    onPrimary: Colors.white, // rengi değiştiriyoruz
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Logout"),
                ),
              ],
            ),
            Container(
              color: Colors.black, // Arka plan rengini siyah yap
              height: 1.5, // Divider kalınlığını ayarla
            ),
            SizedBox(height: 20),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage("assets/images/bahoDagistan.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dagistanlı Baho",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Canım Abimmmm<3<3<3",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/foto10.png",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("15-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/foto2.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forma Tasarımı",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Tiktok yayıncısı XORTO!!",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/foto11.png",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("22-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/ben.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bahrican Arayıcı",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "KRRRAAALLLL",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/foto7.png",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("16-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage("assets/images/karizmatikorcun.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Orçun Demircan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Kolaydı",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/fbgs.jpeg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("17-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/foto3.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Oylol Yoldoz",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cok ogloncolo bor oktovoto.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/konser1.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("18-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage("assets/images/karizmatikorcun.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Orçun Demircan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "6 KASIM 2002",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/fbgs.jpeg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("17-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/foto10.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dagistanlı Baho",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "God of war güzel oyun",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/pp1.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("22-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/pp1.JPG"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cristiano",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "PENALDO",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/ronaldo.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("19-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/sagopa.jpg"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SagopaKajmerMelankolike",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Çok ii çıkmışım",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/sago.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("20-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/foto11.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cristo Roanoaldo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "AlNasr Battı",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/ronaldo2.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("21-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/pp1.JPG"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dagistanlı Baho",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "PENALDO",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/ronaldo.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("19-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/foto2.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DGUCCI TERLIK",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Genç yaş yeni serüven",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/foto11.png",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("22-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage("assets/images/karizmatikorcun.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ORCO",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Kolaydı",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/fbgs.jpeg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("17-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/pepsi.jpg"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lionelmessi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Dünyanın En iyi Takımı Ve Oyuncusu",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/messi.jpg",
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("23-01-2024"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.comment,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CommunicationPage extends StatelessWidget {

  final List<Map<String, String>> communicationLinks = [
    {
      "icon": "assets/icons/insta.png",
      "url": "https://www.instagram.com/orcun.demircan/"
    },
    {"icon": "assets/icons/github.png", "url": "https://github.com/orcundemircan"},
    {
      "icon": "assets/icons/linkedin.png",
      "url": "https://www.linkedin.com/in/orçun-demircan/"
    },
    {"icon": "assets/icons/phone.png", "url": "tel:+905423485554"},
    {"icon": "assets/icons/message.png", "url": "sms:+905423485554"},
    {
      "icon": "assets/icons/mail.png",
      "url":
          "mailto:orcund110@gmail.com?subject=Destek Talebi&body=Merhaba Uygulama İle Problemim var"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İletişim Sayfası'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: communicationLinks.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // Open the URL when tapped
              launch(communicationLinks[index]['url']!);
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    communicationLinks[index]['icon']!,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 8),
                  Text(''),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/ben.png"),
            ),
            SizedBox(height: 20),
            Text(
              'Orçun Demircan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Gelen Gelsin Takımı  Ömer Yiğit Kasap, Bahrican Arayıcı, Orçun Demircan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Bilgileri içeren kartlar
            InfoCard(title: 'Takım', value: 'GelenGelsin'),
            InfoCard(title: 'Yaş', value: '20'),
            InfoCard(title: 'Telefon Numarası', value: '542-348-5554'),
            InfoCard(title: 'Öğrenci Numarası', value: '221216077'),
            InfoCard(title: 'Üniversite', value: 'İstinye Üniversitesi'),
            InfoCard(title: 'Bölüm', value: 'Bilgisayar Programcılığı'),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ListTile(
        title: Center(child: Text(title)),
        subtitle: Center(child: Text(value)),
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  final List<User> users = [
    User('Xorto', 'Bu iş böyle olmaz', 'assets/images/foto2.PNG'),
    User('Oylol', 'Solom boho nopoyorsonn bo oksom??',
        "assets/images/foto3.PNG"),
    User('Ömer Yiğit Kasap', 'Coniii', 'assets/images/ben.png'),
    User('Hakan Yagar', 'canımsın', 'assets/images/pp1.jpg'),
    User('Xorto', 'NERDESİN', 'assets/images/foto2.PNG'),
    User('Xorto', 'Bu iş böyle olmaz', 'assets/images/foto2.PNG'),
    User('Oylol', 'Hocam ayıp oluyo ama', "assets/images/foto3.PNG"),
    User('Xorto', 'Sinirlendirtme adamı', 'assets/images/foto2.PNG'),
    User('Ömer Yiğit Kasap', 'Ödesene lan borcunu', 'assets/images/ben.png'),
    User('Orço', 'Ne zman baba ne zaman', 'assets/images/karizmatikorcun.png'),
    User('Amon Bazidli', 'Bu iş böyle olmaz', 'assets/images/foto2.PNG'),
    User('Oylol', 'sa bilader', "assets/images/foto3.PNG"),
    User('Oylol', 'Basketbol temalı mesajlar', 'assets/images/foto3.PNG'),
    User('Bahrican', 'ayıp ettin hee', 'assets/images/foto2.PNG'),
    User('Hakan Yagar', 'HIIIĞ', 'assets/images/pp1.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesajlar'),
        backgroundColor: const Color.fromARGB(255, 255, 153, 0),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return InboxItem(
            user: users[index],
            onSendMessage: () => _sendMessage(context, users[index]),
          );
        },
      ),
    );
  }

  // Rastgele bir mesaj oluşturmak için kullanılacak metot
  String _generateRandomMessage() {
    List<String> messages = [
      'Merhaba!',
      'Nasılsın?',
      'Bugün nasıl geçti?',
      'Harika bir gün!',
      'Film önerisi var mı?',
      'Hangi takımı tutuyorsun?',
      'Favori film türün nedir?',
      'Basketbol maçlarına gidiyor musun?',
      'Seni tanımak güzel!',
      'Aşk hakkında konuşalım mı?'
    ];

    return messages[Random().nextInt(messages.length)];
  }

  void _sendMessage(BuildContext context, User user) {
    List<Message> sentMessages = [];
    List<Message> receivedMessages = [];

    for (int i = 0; i < 10; i++) {
      sentMessages.add(Message(user, _generateRandomMessage()));
      receivedMessages.add(Message(
          users[Random().nextInt(users.length)], _generateRandomMessage()));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          user: user,
          sentMessages: sentMessages,
          receivedMessages: receivedMessages,
        ),
      ),
    );
  }
}

class InboxItem extends StatelessWidget {
  final User user;
  final VoidCallback onSendMessage;

  InboxItem({required this.user, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(user.profileImage),
      ),
      title: Text(user.name),
      subtitle: Text(user.description),
      onTap: onSendMessage,
    );
  }
}

class ChatScreen extends StatelessWidget {
  final User user;
  final List<Message> sentMessages;
  final List<Message> receivedMessages;

  ChatScreen(
      {required this.user,
      required this.sentMessages,
      required this.receivedMessages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: const Color.fromARGB(255, 255, 153, 0),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sentMessages.length + receivedMessages.length,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  // Gönderilen mesajlar
                  return MessageItem(sentMessages[index ~/ 2], isSent: true);
                } else {
                  // Alınan mesajlar
                  return MessageItem(receivedMessages[index ~/ 2],
                      isSent: false);
                }
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Mesajınızı buraya yazın',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;
  final bool isSent;

  MessageItem(this.message, {required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSent
                ? Color.fromARGB(255, 255, 153, 0)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.text),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String description;
  final String profileImage;

  User(this.name, this.description, this.profileImage);
}

class Message {
  final User sender;
  final String text;

  Message(this.sender, this.text);
}
