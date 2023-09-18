import 'package:flutter/material.dart';
import 'package:timerapp/drawer.dart';
import "dart:async";

import 'package:timerapp/favorite_page.dart';

class TimerPage extends StatefulWidget {
  final int mesafe;

  const TimerPage({super.key, required this.mesafe});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  /*
  Eksikler: Favoriler, 
  Zorunlu mesafe deeğeri,
  clean code
  */
  int saniye = 0, dakika = 0, saat = 0;
  String strsaniye = "00",
      strdakika = "00",
      strsaat = "00"; //değişken isimlerini daha sonra düzelt
  Timer? timer;
  bool basla = false;
  List<String> turlar = [];
  bool favoriDurum = false;
  bool secildi = false;
  List<String> fav = []; //Drawer/Favoriler
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, //ThemeData ile tekrar düzenle
        centerTitle: true,
        title: const Text(
          "TİMER",
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: const DrawerPage(),
      backgroundColor: Colors.blueGrey[800],
      body: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, right: 8.0, bottom: 20.0, left: 8.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blueGrey,
                child: ListView.builder(
                  itemCount: turlar.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ExpansionTile(
                              title: Text(
                                  "${index + 1}. Tur --> ${turlar[index]}",
                                  style: const TextStyle(color: Colors.white)),
                              children: [
                                ListTile(
                                  leading: IconButton(
                                    icon: Icon(
                                      favoriDurum
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favoriDurum
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        favoriDurum = !favoriDurum;
                                        if (favoriDurum != favoriDurum) {
                                          fav.add(turlar[index]);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FavoritePage(
                                                fav: const [],
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                  title: Text(hesapla(widget.mesafe, saniye)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Text(
                "$strsaat:$strdakika:$strsaniye", //Zamanın UI bölümü
                style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                Expanded(
                  //Tekrarlı, düzeltilmeli
                  child: RawMaterialButton(
                    shape: const StadiumBorder(
                        side: BorderSide(
                      color: Colors.blueGrey,
                    )),
                    onPressed: () {
                      (!basla) ? Baslat() : dur();
                    },
                    child: Text(
                      (!basla) ? "Başlat" : "Durdur",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: RawMaterialButton(
                    shape: const StadiumBorder(
                        side: BorderSide(
                      color: Colors.blueGrey,
                    )),
                    onPressed: () {
                      turEkle();
                    },
                    child: const Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: RawMaterialButton(
                    shape: const StadiumBorder(
                        side: BorderSide(
                      color: Colors.blueGrey,
                    )),
                    onPressed: () {
                      sifirla();
                    },
                    child: const Text(
                      "Sıfırla",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: RawMaterialButton(
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                onPressed: () {
                  _tumElemanlariSil();
                },
                child: const Text(
                  "Listeyi Sıfırla",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tumElemanlariSil() {
    setState(() {
      turlar.clear();
    });
  }

  void dur() {
    timer!.cancel();
    setState(() {
      basla = false;
    });
  }

  void sifirla() {
    timer!.cancel();
    setState(() {
      saniye = 0;
      dakika = 0;
      saat = 0;
      strsaniye = "00";
      strdakika = "00";
      strsaat = "00";
      basla = false;
    });
  }

  void turEkle() {
    String turEkle = "$strsaat:$strdakika:$strsaniye";
    setState(() {
      turlar.add(turEkle);
    });
  }

  void Baslat() {
    basla = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        int currentSeconds = saniye + 1;
        int currentMin = dakika;
        int currentHours = saat;

        if (currentSeconds > 59) {
          if (currentMin > 59) {
            currentHours++;
            currentMin = 0;
          } else {
            currentMin++;
            currentSeconds = 0;
          }
        }
        setState(() {
          //Sürenin işleme başlandığı kısım
          saniye = currentSeconds;
          dakika = currentMin;
          saat = currentHours;
          strsaniye = (saniye >= 10) ? "$saniye" : "0$saniye";
          strdakika = (dakika >= 10) ? "$dakika" : "0$dakika";
          strsaat = (saat >= 10) ? "$saat" : "0$saat";
        });
      },
    );
  }

  String hesapla(var mesafe, int saniye) {
    String sonuc = "${mesafe * saniye} metre/saniye";
    return sonuc;
  }
}
