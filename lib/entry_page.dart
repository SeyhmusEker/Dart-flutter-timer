import 'package:flutter/material.dart';
import 'package:timerapp/timer_page.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  late TextEditingController _distanceController;
  int? alinanDeger;
  @override
  void initState() {
    super.initState();
    _distanceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Padding(
        padding: const EdgeInsets.only(
            top: 30.0, right: 10.0, left: 10.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {
                alinanDeger = int.tryParse(value);
              },
              controller: _distanceController,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, letterSpacing: 3),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(25.0),
                labelText: "Mesafe değerini giriniz(metre)",
                labelStyle: const TextStyle(
                    fontSize: 17, color: Colors.white, letterSpacing: 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TimerPage(mesafe: alinanDeger ?? 0),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Let's",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
